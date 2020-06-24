close all
clear
clc

%% STEP 1 dan 2 (Membuat Database Matrik Pelatihan)
folder1 = 'DataPelatihan';
namafolder = 'abcdefghijklmnopqrst';
ext = '.tiff';
n_file = 1:15;
count = 0;
class = '';
for i = namafolder
  for j = n_file
    namafile = ['./' folder1 '/' i '/' i num2str(j) ext];
    image = imread(namafile);
    if exist('X') == 0
      X = zeros(length(n_file),prod(size(image)));
    end
    count = count + 1;
    X(count,:) = reshape(double(image),1,prod(size(image)));
    class(count) = i;
  end
end

%% STEP 3 (Rataan Matrik Pelatihan)
Psi = mean(X);

%% STEP 4 (Zero-mean)
Phi = X - repmat(Psi,size(X,1),1);

%% STEP 5 dan 6 (Hitung Kovarian Matrix beserta eigen-nya)
if size(X,1) > size(X,2)
  C = Phi.'*Phi;
else
  C = Phi*Phi.';
end
[Lambda v] = eig(C);

%% STEP 7 (Hitung eigenface)
[v, id] = sort(diag(v),'descend');
if size(X,1) > size(X,2)  
  U = Lambda(:,id);
else
  U = Phi.'*Lambda;
  % normalisasi eigenface
  for i = 1:size(X,1)
    U(:,i) = U(:,i)/norm(U(:,i));
  end
  U = U(:,id);
end
% jumlah komponen penting yang digunakan (reduksi)
k = size(X,1); % maksimum (boleh dikurangi)
U = U(:,1:k);

%% Kumpulan Vektor Pelatihan
Omega = (X-repmat(Psi,size(X,1),1))*U;

%% Proyeksi Gambar Uji dan Vektor Uji
folder2 = 'DataUji';
namafileuji = ['./' folder2 '/' 'b' '/' 'b20' ext];
ImageUji = imread(namafileuji);
Xuji = reshape(double(ImageUji),1,prod(size(ImageUji)));
Omega_k = (Xuji-Psi)*U;

%% Penggolongan
for i = 1:size(Omega,1)
  mini(i) = min(norm(Omega(i,:)-Omega_k));
end
[minimal idmin] = min(mini);
disp(['Gambar uji termasuk gambar pelatihan golongan ' class(idmin)])

figure
subplot(121)
imshow(ImageUji)
title('Test Image')
subplot(122)
imshow(reshape(uint8(X(idmin,:)),size(ImageUji,1),size(ImageUji,2)))

%%Nama-nama :
if class(idmin)=='a'
    title({'Training Data Image :', 'Vannya Maheswari'})
end
if class(idmin)=='b'
    title({'Training Data Image :', 'Jonathan Purnama Halim'})
end
if class(idmin)=='c'
    title({'Training Data Image :','Ivan William'})
end
if class(idmin)=='d'
    title({'Training Data Image :', 'Kho Sendy Ardianto'})
end
if class(idmin)=='e'
    title({'Training Data Image :', 'Hendrawan Raharjo'})
end
if class(idmin)=='f'
    title({'Training Data Image :', 'Nita Vania'})
end
if class(idmin)=='g'
    title({'Training Data Image :' ,'Jonathan Sulistio Jusuf'})
end
if class(idmin)=='h'
    title({'Training Data Image :', 'Daniel Ekanata'})
end
if class(idmin)=='i'
    title({'Training Data Image :', 'Rodolf Valentino'})
end
if class(idmin)=='j'
    title({'Training Data Image :', 'Wong Feren'})
end
if class(idmin)=='k'
    title({'Training Data Image :', 'Lily Gunawan'})
end
if class(idmin)=='l'
    title({'Training Data Image :', 'Felix'})
end
if class(idmin)=='m'
    title({'Training Data Image :', 'Velincia Sepvilita'})
end
if class(idmin)=='n'
    title({'Training Data Image :', 'Laksita Maulisa Liztio'})
end
if class(idmin)=='o'
    title({'Training Data Image :', 'Selly Oktaviani'})
end
if class(idmin)=='p'
    title({'Training Data Image :', 'Ari Hilda Mawaddah'})
end
if class(idmin)=='q'
    title({'Training Data Image :', 'Aghitsna Sabila'})
end
if class(idmin)=='r'
    title({'Training Data Image :', 'Daffa Fajri Riesaputri'})
end
if class(idmin)=='s'
    title({'Training Data Image :', 'Jang Hansol'})
end
if class(idmin)=='t'
    title({'Training Data Image :', 'Ronal Venas'})
end
