
function [A_all_isdigit, b_all_isdigit] = CreateAB(digit,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9)
A_all_isdigit = zeros(10*N,28^2);
b_all_isdigit = zeros(10*N,1);
for i=1:N
    A_all_isdigit(10*i-9,:) = reshape(imagesPerDigit0(:,:,i),1,28*28);
    b_all_isdigit(10*i-9)   = -1;
    A_all_isdigit(10*i-8,:) = reshape(imagesPerDigit1(:,:,i),1,28*28);
    b_all_isdigit(10*i-8)   = -1;
    A_all_isdigit(10*i-7,:) = reshape(imagesPerDigit2(:,:,i),1,28*28);
    b_all_isdigit(10*i-7)   = -1;
    A_all_isdigit(10*i-6,:) = reshape(imagesPerDigit3(:,:,i),1,28*28);
    b_all_isdigit(10*i-6)   = -1;
    A_all_isdigit(10*i-5,:) = reshape(imagesPerDigit4(:,:,i),1,28*28);
    b_all_isdigit(10*i-5)   = -1;
    A_all_isdigit(10*i-4,:) = reshape(imagesPerDigit5(:,:,i),1,28*28);
    b_all_isdigit(10*i-4)   = -1;
    A_all_isdigit(10*i-3,:) = reshape(imagesPerDigit6(:,:,i),1,28*28);
    b_all_isdigit(10*i-3)   = -1;
    A_all_isdigit(10*i-2,:) = reshape(imagesPerDigit7(:,:,i),1,28*28);
    b_all_isdigit(10*i-2)   = -1;
    A_all_isdigit(10*i-1,:) = reshape(imagesPerDigit8(:,:,i),1,28*28);
    b_all_isdigit(10*i-1)   = -1;
    A_all_isdigit(10*i,:) = reshape(imagesPerDigit9(:,:,i),1,28*28);
    b_all_isdigit(10*i)   = -1;
    % Special digit:
    b_all_isdigit(10*i-(10-digit-1))   = 1;
end
A_all_isdigit = [A_all_isdigit, ones(10*N,1)];

end