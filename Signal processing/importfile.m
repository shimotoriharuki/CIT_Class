function importfile(fileToRead1)
%IMPORTFILE(FILETOREAD1)
%  �w�肵���t�@�C������f�[�^���C���|�[�g
%  FILETOREAD1:  �ǂݎ��t�@�C��

%  MATLAB ����̎���������: 16-Dec-2019 22:43:53

% �t�@�C�����C���|�[�g
newData1 = importdata(fileToRead1);

% �����̃t�B�[���h����A�x�[�X ���[�N�X�y�[�X���ɐV�K�ϐ����쐬���܂��B
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end

