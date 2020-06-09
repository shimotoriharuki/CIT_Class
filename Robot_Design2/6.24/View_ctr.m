%Viwer 画面サイズ変更

sys_para = get(0)%システムのパラメータを取得
XY = sys_para.MonitorPositions%画面サイズを取得
X = XY(3);%画面サイズX
Y = XY(4);%画面サイズY
VX = floor(X/2);%SLモデルの画面サイズ(x)はモニターサイズの半分とする
VY = floor(Y/2);%SLモデルの画面サイズ(y)はモニターサイズの半分とする

%gcs:カレントモデル名(get current systemの意味)
%モデルパラメータ'Location'を変更
set_param(gcs,'Location',[1 1 VX VY])

%画面フィット
%注記：
%モデルパラメータ'ZoomFactor'を56に変更
%56は現モデルの画面全体のズームファクター
set_param(gcs,'ZoomFactor','56')

