%% Digital Signal Processing Project- Gender Identification and Classification                                    
clc;
%% Program:

%Reading a file and getting the fundamental frequency, zero crossing, short energy
%values
[my2,fs] = audioread('s1.wav');

%menampilkan grafik
figure;
plot(my2);title('Test Signal');
xlabel('Index');ylabel('Amplitude');

%mengambil nilai
[fundamental_frequency,zero_crossing,short_energy]=Charac_features(my2,fs);

%% prediksi
load train1
fundamental_frequency
zero_crossing
short_energy
  
  %normalisasi data
  normalS1 = (fundamental_frequency-104.1667)/(217.3913-104.1667);
  normalS2 = (zero_crossing-3.1818)/(25.3393-3.1818);
  normalS3 = (short_energy-0.1278)/(8.2358-0.1278);
      
Uji = [normalS1;normalS2;normalS3];

%% simulasi
an=round(sim(train1,Uji));

switch an
    case 0
        hasil = 'Perempuan'
    case 1
        hasil = 'Laki - Laki'
end

%play sound
sound(my2,fs)