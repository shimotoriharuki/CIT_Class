%Viwer ��ʃT�C�Y�ύX

sys_para = get(0)%�V�X�e���̃p�����[�^���擾
XY = sys_para.MonitorPositions%��ʃT�C�Y���擾
X = XY(3);%��ʃT�C�YX
Y = XY(4);%��ʃT�C�YY
VX = floor(X/2);%SL���f���̉�ʃT�C�Y(x)�̓��j�^�[�T�C�Y�̔����Ƃ���
VY = floor(Y/2);%SL���f���̉�ʃT�C�Y(y)�̓��j�^�[�T�C�Y�̔����Ƃ���

%gcs:�J�����g���f����(get current system�̈Ӗ�)
%���f���p�����[�^'Location'��ύX
set_param(gcs,'Location',[1 1 VX VY])

%��ʃt�B�b�g
%���L�F
%���f���p�����[�^'ZoomFactor'��56�ɕύX
%56�͌����f���̉�ʑS�̂̃Y�[���t�@�N�^�[
set_param(gcs,'ZoomFactor','56')

