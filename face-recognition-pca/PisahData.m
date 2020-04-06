close all
clear
clc

namafile = 'abcdefghijk';
n_pelatihan = 1:15;
n_pengujian = 16:20;
ext = '.tiff';

folder0 = 'database';
folder1 = 'DataPelatihan';
folder2 = 'DataUji';

if isdir(folder1) == 0
   mkdir(folder1);
end

if isdir(folder2) == 0
   mkdir(folder2);
end

for i = 1:length(namafile)
   f2 = namafile(i);
   
   if isdir(['./' folder1 '/' namafile(i)]) == 0
      mkdir(['./' folder1 '/' namafile(i)]);
   end
   for j = 1:length(n_pelatihan)
       f1 = [namafile(i) num2str(n_pelatihan(j)) ext];
       copyfile(['./' folder0 '/' f1],['./' folder1 '/' f2 '/'],'f');
   end
   
   if isdir(['./' folder2 '/' namafile(i)]) == 0
      mkdir(['./' folder2 '/' namafile(i)]);
   end
   for j = 1:length(n_pengujian)
       f1 = [namafile(i) num2str(n_pengujian(j)) ext];
       copyfile(['./' folder0 '/' f1],['./' folder2 '/' f2 '/'],'f');
   end
end
