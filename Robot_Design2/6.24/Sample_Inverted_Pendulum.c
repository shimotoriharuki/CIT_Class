//###########################################################################
//			��t�H�Ƒ�w�������{�e�B�N�X�w�ȁ@���{�b�g�݌v����_�y�щ��K2
//###########################################################################
//�@���|���U�q����v���O����
// �y�g�p����ӏ��z
//   I/O�{�[�h	D1: �G���R�[�_
//   I/O�{�[�h	D2: �G���R�[�_
//   I/O�{�[�h	D3: �G���R�[�_
//   I/O�{�[�h	D4: �G���R�[�_
//   ���[�^�{�[�h	CN3�F�@DC���[�^
//   ���[�^�{�[�h	CN5�F�@DC���[�^
//   ���[�^�{�[�h	�C�ӂ̒[�q: �|�e���V�����[�^�i�M�����j
//   ���[�^�{�[�h	3.3V�[�q: �|�e���V�����[�^�i�d���j
//   ���[�^�{�[�h	GND�[�q: �|�e���V�����[�^�iGND�j
//
//�@�y�֐��z
// cpu_timer0_isr(): �^�C�}0���荞�݊֐�
//					 0.5[ms]�����Ŏ��s
// controller_func(): ���䑥���s�֐�
//
//                               2012/03/28 rewritten by ikeda@E-Sys Lab.
//												2010/06/02	h.yamato@fuRo
//###########################################################################
#include <float.h>
#include "DSP28x_Project.h"     // Device Headerfile and Examples Include File
#include "NolibM.h"

// Target value
#define TARGET_ADV 2024
// Used in PID control
#define KP  0.1f
#define KI  0.1f
#define KD  0.1f
// Used in state feedback control
#define K1  0.1f
#define K2  0.1f
#define K3  0.1f
#define K4  0.1f
// Used in reading digital value
#define T   0.1f
#define ADV_TO_RAD 0.1f
#define RAD_TO_DEG 0.1f
#define PULSE_TO_METER 0.1f

#define MOTOR_OFFSET 30

#define K	0.5

// Prototype statements for functions found within this file.
interrupt void cpu_timer0_isr(void);
void controller_func(void);

volatile struct EPWM_REGS *ePWM[] = 
 				  { &EPwm1Regs,			//intentional: (ePWM[0] not used)
				  	&EPwm1Regs,
					&EPwm2Regs,
					&EPwm3Regs,
					&EPwm4Regs,
					&EPwm5Regs,
					&EPwm6Regs,
					&EPwm7Regs,
				  };

long left = 0, right = 0;
long e=0, ed=0, ei=0, e0=0;
float x=0.0f, dx=0.0f, x0=0.0f, theta=0.0f, dtheta=0.0f, theta0=0.0f;
int adv = 0;
int	adv_filter1, adv_filter1_1, adv_filter1_2;
int	adv_filter2, adv_filter2_1;
int duty_ratio = 0;

/***************************************************/
/*	���C���֐�										   */
/***************************************************/
void main(void)
{
	initNolibM();	//������
	
//	lcd_INIT();
	
	EALLOW;			// GPIO���G���R�[�_�ǂݎ��p�ɐݒ�
	GpioCtrlRegs.GPBMUX1.bit.GPIO40 = 0;	// 0=GPIO,  1=EPWM7A,  2=Resv,  3=Resv
	GpioCtrlRegs.GPBMUX1.bit.GPIO41 = 0;	// 0=GPIO,  1=EPWM7B,  2=Resv,  3=Resv
	GpioCtrlRegs.GPAMUX1.bit.GPIO9 = 0;		// 0=GPIO,  1=EPWM5B,  2=LINTX-A,  3=Resv
	GpioCtrlRegs.GPAMUX1.bit.GPIO11 = 0;	// 0=GPIO,  1=EPWM6B,  2=LINRX-A,  3=Resv
	GpioCtrlRegs.GPBDIR.bit.GPIO41 = 0;		// 1=OUTput,  0=INput
	GpioCtrlRegs.GPBDIR.bit.GPIO40 = 0;		// 1=OUTput,  0=INput
	GpioCtrlRegs.GPADIR.bit.GPIO9 = 0;		// 1=OUTput,  0=INput
	GpioCtrlRegs.GPADIR.bit.GPIO11 = 0;		// 1=OUTput,  0=INput
	GpioCtrlRegs.GPBPUD.bit.GPIO40 = 0;
	GpioCtrlRegs.GPBPUD.bit.GPIO41 = 0;
	GpioCtrlRegs.GPAPUD.bit.GPIO9 = 0;
	GpioCtrlRegs.GPAPUD.bit.GPIO11 = 0;
	EDIS;
	
	EALLOW;
//	Wrote "NolibM.c"
//	ConfigCpuTimer(&CpuTimer0, 60, 500);  // 0.5[ms]���荞�݁i 0.5[ms]=500[cnt]/(60[MHz]/60) �j  // ����1: �Ώ�, ����2: �v���X�P�[��, ����3: �I�[�o�[�t���[�l
	PieVectTable.TINT0 = &cpu_timer0_isr;
	EDIS;
	
	IER |= M_INT1;
	PieCtrlRegs.PIEIER1.bit.INTx7 = 1;
	EINT;
	ERTM;
	
	
	for(;;) //�@�������[�v
	{
		wait(500);
		ledFlash(TOGGLE, 2);
	}
}// End of main()

/***************************************************/
/*	���䑥���s�֐�								   */
/*	�^�C�}0���荞�ݓ��ŌĂԂ��ƂŎ����I�Ɏ��s			   */
/***************************************************/
void controller_func(void)
{
	adv = sensor(ADCINB7);
	/*  �t�B���^�����p
	adv_filter1	= (int)((adv + adv_filter1_1 + adv_filter1_2)/3.0);
	adv_filter2 = (int)(( K * adv + (1.0-K) * adv_filter2_1));
    rs_printf("%d, %d, %d\n", adv, adv_filter1, adv_filter2);
	adv_filter1_2 = adv_filter1_1;
	adv_filter1_1 = adv;
	adv_filter2_1 = adv_filter2;	//���ۂ̓R�[�h���k�\
	*/
	e = TARGET_ADV - adv;
	ed = e - e0;
	ei += e;
	e0 = e;
	
	if(ei > 10000) ei = 10000;
	if(ei > -10000) ei = -10000;

//  Calculate PID control
	duty_ratio = (int)(e * KP + ei * KI + ed * KD);
	
	x = (float)(left + right) / 2 * PULSE_TO_METER;
	dx = (x - x0) / T;
	x0 = x;
	theta = (float)(TARGET_ADV - adv) * ADV_TO_RAD;
	dtheta = (theta - theta0) / T;
	theta0 = theta;

//  Calculate state feedback control
//	duty_ratio = -(int)((x*K1 + dx*K2 + theta*K3 + dtheta*K4)*100);
	
//	if(duty_ratio > 0) duty_ratio += MOTOR_OFFSET;
//	if(duty_ratio < 0) duty_ratio -= MOTOR_OFFSET;
	if (duty_ratio > 100) duty_ratio = 100;
	else if (duty_ratio < -100) duty_ratio = -100;
	
	if(sw1(0)){
		motor(0, MotCN5);
		motor(0, MotCN3);
	}else{
		motor(duty_ratio, MotCN5);
		motor(duty_ratio, MotCN3);
	}
}


/***************************************************/
/*	�^�C�}0���荞�݊֐�								   */
/***************************************************/
interrupt void cpu_timer0_isr(void)
{
	static char en[16] = {0,1,-1,0,-1,0,0,1,1,0,0,-1,0,-1,1,0};
	static int count = 0;
	static int a0 = 0, b0 = 0, a1 = 0, b1 = 0;
	static int time_cnt = 0;
	int a, b;

	CpuTimer0.InterruptCount++;
	
	// ���荞�݂�����ɍs���Ă��邩�̃`�F�b�N�p
	count ++;
	if (count >= 1000){
	    count = 0;
		ledFlash(TOGGLE, 1);
	}
	
	// �G���R�[�_�̃J�E���g
	a = GpioDataRegs.GPBDAT.bit.GPIO40;
	b = GpioDataRegs.GPBDAT.bit.GPIO41;
	left  -= en[(a << 3)+(a0 << 2)+(b << 1)+b0];
	a0 = a;
	b0 = b;
	
	a = GpioDataRegs.GPADAT.bit.GPIO9;
	b = GpioDataRegs.GPADAT.bit.GPIO11;
	right += en[(a << 3)+(a1 << 2)+(b << 1)+b1];
	a1 = a;
	b1 = b;
	// �G���R�[�_�̃J�E���g�����I

	time_cnt++;
	if(time_cnt == 40){  // 20[ms] = 0.5[ms] * 40
		time_cnt = 0;
		controller_func();
	}

	PieCtrlRegs.PIEACK.all = PIEACK_GROUP1;
}
