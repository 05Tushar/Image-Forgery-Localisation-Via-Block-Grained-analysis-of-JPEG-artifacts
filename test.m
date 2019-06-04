filename_NA = 'florence2_tamp95_3_7.jpg';
% set parameters
ncomp=1;
c2=6;
image = jpeg_read(filename_NA);
coeffArray = image.coef_arrays{ncomp};
qtable = image.quant_tables{image.comp_info(ncomp).quant_tbl_no};

%Cropping and then take block DCT
I = ibdct(dequantize(coeffArray, qtable));        %Pixel values after JPEG compression
k1e = 3;    %These two variables 
k2e = 5;    %represent the shifts
cropped_image=I(k1e:end,k2e:end);    %Image cropping
dct_coeff=bdct(cropped_image);       %Taking block DCT

% Method used in the code
ic1=2;      %These two variable represent
ic2=1;      %index of coeffecient we want
A = zeros(8);
A(ic1,ic2) = 1;         %Only the coordinate corresponding to the coordinate we want is non zero
B = idct2(A);           %Inverse dct
AC = conv2(I, B);       %Convolution in spatial domain
AC = AC(8:end,8:end);    
ACpoly = AC(k1e:8:end,k2e:8:end);     %Taking values correspondung to the shift

%Extracting the ceffecients using Method 1
req_coeff=dct_coeff(ic1:8:end,ic2:8:end);