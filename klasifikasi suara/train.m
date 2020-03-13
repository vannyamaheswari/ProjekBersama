load train1;
xlsdata=xlsread('data.xlsx',1,'a2:d12');
urut = 1:11;
data = xlsdata(urut(1:end),:);
P=data(:,1:3)';
T=data(:,4)';

a1=500; %epoch
a2=0.01; %learning rate
a3=0.01; %goal
a4=6; %neuron hidden layer

%% membangun jaringan saraf tiruan
net = newff(minmax(P),[a4 1],{'logsig','purelin'},'traingdx');

%% paramater jaringan
net.trainParam.epochs=a1;
net.trainParam.goal=a3;
net.trainParam.lr=a2;
net.trainParam.show=1;
net.trainParam.mc = 0.5;
net.performFcn='msereg';
net.performParam.ratio=0.5;

% pelatihan jaringan
[train1,tr]=train(net,P,T);
save train1 train1;

%=====================================
%% simulasi
%read data
load train1;
xlsdata2=xlsread('data.xlsx',1,'a2:d12');
urut = 1:11;
datatesting = xlsdata2(urut(1:end),:);
P2=datatesting(:,1:3)';
T2=datatesting(:,4)';
[m,n] = size(P2);
an= round(sim(train1,P2));
cek=[an' T2']

%hitung error
compareA = T2 == an;
hitung = sum(compareA == 0);

akurasi_error=(hitung./n)*100;
akurasi_berhasil = 100-akurasi_error

mat = T2-an;
m1 = mat.^2;
MSE = mean(m1)

