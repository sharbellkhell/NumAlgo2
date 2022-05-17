clc; clear;

%% ======================= Parameters ===========================

N = 4000;
digit0 = 0;
digit1 = 1;
digit2 = 2;
digit3 = 3;
digit4 = 4;
digit5 = 5;
digit6 = 6;
digit7 = 7;
digit8 = 8;
digit9 = 9;

%%  ==================== Load MNIST dataset ======================
load('mnist.mat');
imagesPerDigit0 = training.images(:,:,training.labels == digit0);
imagesPerDigit1 = training.images(:,:,training.labels == digit1);
imagesPerDigit2 = training.images(:,:,training.labels == digit2);
imagesPerDigit3 = training.images(:,:,training.labels == digit3);
imagesPerDigit4 = training.images(:,:,training.labels == digit4);
imagesPerDigit5 = training.images(:,:,training.labels == digit5);
imagesPerDigit6 = training.images(:,:,training.labels == digit6);
imagesPerDigit7 = training.images(:,:,training.labels == digit7);
imagesPerDigit8 = training.images(:,:,training.labels == digit8);
imagesPerDigit9 = training.images(:,:,training.labels == digit9);


%% ======================= Create A, b ============================



%LS - Zero or not zero? 
% If digit is 0 -> 1
% If digit is not 0 -> -1
A_all_is0 = zeros(10*N,28^2);
b_all_is0 = zeros(10*N,1);
for i=1:N
    A_all_is0(10*i-9,:) = reshape(imagesPerDigit0(:,:,i),1,28*28);
    b_all_is0(10*i-9)   = 1;
    A_all_is0(10*i-8,:) = reshape(imagesPerDigit1(:,:,i),1,28*28);
    b_all_is0(10*i-8)   = -1;
    A_all_is0(10*i-7,:) = reshape(imagesPerDigit2(:,:,i),1,28*28);
    b_all_is0(10*i-7)   = -1;
    A_all_is0(10*i-6,:) = reshape(imagesPerDigit3(:,:,i),1,28*28);
    b_all_is0(10*i-6)   = -1;
    A_all_is0(10*i-5,:) = reshape(imagesPerDigit4(:,:,i),1,28*28);
    b_all_is0(10*i-5)   = -1;
    A_all_is0(10*i-4,:) = reshape(imagesPerDigit5(:,:,i),1,28*28);
    b_all_is0(10*i-4)   = -1;
    A_all_is0(10*i-3,:) = reshape(imagesPerDigit6(:,:,i),1,28*28);
    b_all_is0(10*i-3)   = -1;
    A_all_is0(10*i-2,:) = reshape(imagesPerDigit7(:,:,i),1,28*28);
    b_all_is0(10*i-2)   = -1;
    A_all_is0(10*i-1,:) = reshape(imagesPerDigit8(:,:,i),1,28*28);
    b_all_is0(10*i-1)   = -1;
    A_all_is0(10*i,:) = reshape(imagesPerDigit9(:,:,i),1,28*28);
    b_all_is0(10*i)   = -1;
end
A_all_is0 = [A_all_is0, ones(10*N,1)];




%% ========================= Solve LS ==============================
A_train_is0 = A_all_is0(1:N,:); 
b_train_is0 = b_all_is0(1:N); 
x_is0=pinv(A_train_is0)*b_train_is0; 
A_test_is0 = A_all_is0(N+1:10*N,:); 
b_test_is0 = b_all_is0(N+1:10*N); 


%% ===================== Check Performance ===========================

% Check on training data
pred_train_is0 = sign(A_train_is0*x_is0);
disp('Train Error:'); 
acc=mean(pred_train_is0 == b_train_is0)*100;
disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 


% Check on testing data
pred_test_is0 = sign(A_test_is0*x_is0);
disp('Test Error:'); 
acc=mean(pred_test_is0 == b_test_is0)*100;
disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 

%% ================= Show the Problematric Images ====================

error = find(pred_train_is0~=b_train_is0); 
for k=1:1:length(error)
    figure(2);
    imagesc(reshape(A_train_is0(error(k),1:28^2),[28,28]));
    colormap(gray(256))
    axis image; axis off; 
    title(['problematic digit number ',num2str(k),' :',num2str(A_train_is0(error(k),:)*x_is0)]); 
    pause;  
end
	