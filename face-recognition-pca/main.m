close all
clear
clc

%% STEP 1 dan 2 (Membuat Database Matrik Pelatihan)
folder1 = 'DataPelatihan';
namafolder = 'abcdefghijk';
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
namafileuji = ['./' folder2 '/' 'k' '/' 'k16' ext];
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
title('Gambar Uji')
subplot(122)
imshow(reshape(uint8(X(idmin,:)),size(ImageUji,1),size(ImageUji,2)))
if class(idmin)=='h'
    %title('Gambar dari Data Pelatihan')
    title('Vannya elek')
else
    title('mantab')
end