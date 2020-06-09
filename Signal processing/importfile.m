function importfile(fileToRead1)
%IMPORTFILE(FILETOREAD1)
%  指定したファイルからデータをインポート
%  FILETOREAD1:  読み取るファイル

%  MATLAB からの自動生成日: 16-Dec-2019 22:43:53

% ファイルをインポート
newData1 = importdata(fileToRead1);

% これらのフィールドから、ベース ワークスペース内に新規変数を作成します。
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end

