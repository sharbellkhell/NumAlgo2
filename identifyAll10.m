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

% ------- Little bit of exploration to feel the data -------------
whos
disp(training); 
disp(size(training.images));
imagesc(training.images(:,:,10)); axis image; colormap(gray(256)); 
title(['This image label is ',num2str(training.labels(10))]);
% ----------------------------------------------------------------

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


%figure(1); 
%for k=1:1:100
%    imagesc(imagesPerDigit4(:,:,k));
%    colormap(gray(256))
%    axis image; axis off; 
%    pause(0.1);
%end


%% ======================= Create A, b ============================



%First LS - Odd or even? (Even = 1)
A_all_evenOdd = zeros(10*N,28^2);
b_all_evenOdd = zeros(10*N,1);
for i=1:N
    A_all_evenOdd(10*i-9,:) = reshape(imagesPerDigit0(:,:,i),1,28*28);
    b_all_evenOdd(10*i-9)   = 1;
    A_all_evenOdd(10*i-8,:) = reshape(imagesPerDigit1(:,:,i),1,28*28);
    b_all_evenOdd(10*i-8)   = -1;
    A_all_evenOdd(10*i-7,:) = reshape(imagesPerDigit2(:,:,i),1,28*28);
    b_all_evenOdd(10*i-7)   = 1;
    A_all_evenOdd(10*i-6,:) = reshape(imagesPerDigit3(:,:,i),1,28*28);
    b_all_evenOdd(10*i-6)   = -1;
    A_all_evenOdd(10*i-5,:) = reshape(imagesPerDigit4(:,:,i),1,28*28);
    b_all_evenOdd(10*i-5)   = 1;
    A_all_evenOdd(10*i-4,:) = reshape(imagesPerDigit5(:,:,i),1,28*28);
    b_all_evenOdd(10*i-4)   = -1;
    A_all_evenOdd(10*i-3,:) = reshape(imagesPerDigit6(:,:,i),1,28*28);
    b_all_evenOdd(10*i-3)   = 1;
    A_all_evenOdd(10*i-2,:) = reshape(imagesPerDigit7(:,:,i),1,28*28);
    b_all_evenOdd(10*i-2)   = -1;
    A_all_evenOdd(10*i-1,:) = reshape(imagesPerDigit8(:,:,i),1,28*28);
    b_all_evenOdd(10*i-1)   = 1;
    A_all_evenOdd(10*i,:) = reshape(imagesPerDigit9(:,:,i),1,28*28);
    b_all_evenOdd(10*i)   = -1;
end
A_all_evenOdd = [A_all_evenOdd, ones(10*N,1)];

maxACC = 0;
maxIndex = 0;
%Second LS - Between 0,2,4,6,8 
% If digit is 4 -> 1
% If digit is not 4 -> -1
A_all_EvenIs4 = zeros(5*N,28^2);
b_all_EvenIs4 = zeros(5*N,1);
for i=1:N
    A_all_EvenIs4(5*i-4,:) = reshape(imagesPerDigit0(:,:,i),1,28*28);
    b_all_EvenIs4(5*i-4)   = -1;
    A_all_EvenIs4(5*i-3,:) = reshape(imagesPerDigit2(:,:,i),1,28*28);
    b_all_EvenIs4(5*i-3)   = -1;
    A_all_EvenIs4(5*i-2,:) = reshape(imagesPerDigit4(:,:,i),1,28*28);
    b_all_EvenIs4(5*i-2)   = 1;
    A_all_EvenIs4(5*i-1,:) = reshape(imagesPerDigit6(:,:,i),1,28*28);
    b_all_EvenIs4(5*i-1)   = -1;
    A_all_EvenIs4(5*i,:) = reshape(imagesPerDigit8(:,:,i),1,28*28);
    b_all_EvenIs4(5*i)   = -1;
end
A_all_EvenIs4 = [A_all_EvenIs4, ones(5*N,1)];

% LS - Between 0,2,4,6,8 
% If digit is 0 or 2 -> -1
% If digit is 6 or 8 -> 1
A_all_02or68 = zeros(4*N,28^2);
b_all_02or68 = zeros(4*N,1);
for i=1:N
    A_all_02or68(4*i-3,:) = reshape(imagesPerDigit0(:,:,i),1,28*28);
    b_all_02or68(4*i-3)   = -1;
    A_all_02or68(4*i-2,:) = reshape(imagesPerDigit2(:,:,i),1,28*28);
    b_all_02or68(4*i-2)   = -1;
    A_all_02or68(4*i-1,:) = reshape(imagesPerDigit6(:,:,i),1,28*28);
    b_all_02or68(4*i-1)   = 1;
    A_all_02or68(4*i,:) = reshape(imagesPerDigit8(:,:,i),1,28*28);
    b_all_02or68(4*i)   = 1;
end
A_all_02or68 = [A_all_02or68, ones(4*N,1)];


% Third LS - Between 1,3,5,7,9
% If digit is 5 -> 1
% If digit is not 5 -> -1
A_all_OddIs5 = zeros(5*N,28^2);
b_all_OddIs5 = zeros(5*N,1);
for i=1:N
    A_all_OddIs5(5*i-4,:) = reshape(imagesPerDigit1(:,:,i),1,28*28);
    b_all_OddIs5(5*i-4)   = -1;
    A_all_OddIs5(5*i-3,:) = reshape(imagesPerDigit3(:,:,i),1,28*28);
    b_all_OddIs5(5*i-3)   = -1;
    A_all_OddIs5(5*i-2,:) = reshape(imagesPerDigit5(:,:,i),1,28*28);
    b_all_OddIs5(5*i-2)   = 1;
    A_all_OddIs5(5*i-1,:) = reshape(imagesPerDigit7(:,:,i),1,28*28);
    b_all_OddIs5(5*i-1)   = -1;
    A_all_OddIs5(5*i,:) = reshape(imagesPerDigit9(:,:,i),1,28*28);
    b_all_OddIs5(5*i)   = -1;
end
A_all_OddIs5 = [A_all_OddIs5, ones(5*N,1)];

% LS - Between 1,3,5,7,9 
% If digit is 1 or 3 -> -1
% If digit is 7 or 9 -> 1
A_all_13or79 = zeros(4*N,28^2);
b_all_13or79 = zeros(4*N,1);
for i=1:N
    A_all_13or79(4*i-3,:) = reshape(imagesPerDigit1(:,:,i),1,28*28);
    b_all_13or79(4*i-3)   = -1;
    A_all_13or79(4*i-2,:) = reshape(imagesPerDigit3(:,:,i),1,28*28);
    b_all_13or79(4*i-2)   = -1;
    A_all_13or79(4*i-1,:) = reshape(imagesPerDigit7(:,:,i),1,28*28);
    b_all_13or79(4*i-1)   = 1;
    A_all_13or79(4*i,:) = reshape(imagesPerDigit9(:,:,i),1,28*28);
    b_all_13or79(4*i)   = 1;
end
A_all_13or79 = [A_all_13or79, ones(4*N,1)];

% Fourth LS - Between 0,2
% If digit is 2 -> 1
% If digit is 0 -> -1
A_all_0or2 = zeros(2*N,28^2);
b_all_0or2 = zeros(2*N,1);
for i=1:N
    A_all_0or2(2*i-1,:) = reshape(imagesPerDigit0(:,:,i),1,28*28);
    b_all_0or2(2*i-1)   = -1;
    A_all_0or2(2*i,:) = reshape(imagesPerDigit2(:,:,i),1,28*28);
    b_all_0or2(2*i)   = 1;
end
A_all_0or2 = [A_all_0or2, ones(2*N,1)];

% Fifth LS - Between 6,8
% If digit is 6 -> -1
% If digit is 8 -> 1
A_all_6or8 = zeros(2*N,28^2);
b_all_6or8 = zeros(2*N,1);
for i=1:N
    A_all_6or8(2*i-1,:) = reshape(imagesPerDigit6(:,:,i),1,28*28);
    b_all_6or8(2*i-1)   = -1;
    A_all_6or8(2*i,:) = reshape(imagesPerDigit8(:,:,i),1,28*28);
    b_all_6or8(2*i)   = 1;
end
A_all_6or8 = [A_all_6or8, ones(2*N,1)];

% Sixth LS - Between 1,3
% If digit is 1 -> -1
% If digit is 3 -> 1
A_all_1or3 = zeros(2*N,28^2);
b_all_1or3 = zeros(2*N,1);
for i=1:N
    A_all_1or3(2*i-1,:) = reshape(imagesPerDigit1(:,:,i),1,28*28);
    b_all_1or3(2*i-1)   = -1;
    A_all_1or3(2*i,:) = reshape(imagesPerDigit3(:,:,i),1,28*28);
    b_all_1or3(2*i)   = 1;
end
A_all_1or3 = [A_all_1or3, ones(2*N,1)];

% Seventh LS - Between 7,9
% If digit is 7 -> -1
% If digit is 9 -> 1
A_all_7or9 = zeros(2*N,28^2);
b_all_7or9 = zeros(2*N,1);
for i=1:N
    A_all_7or9(2*i-1,:) = reshape(imagesPerDigit7(:,:,i),1,28*28);
    b_all_7or9(2*i-1)   = -1;
    A_all_7or9(2*i,:) = reshape(imagesPerDigit9(:,:,i),1,28*28);
    b_all_7or9(2*i)   = 1;
end
A_all_7or9 = [A_all_7or9, ones(2*N,1)];



%% ========================= Solve LS ==============================
A_train_evenOdd = A_all_evenOdd(1:N,:); 
b_train_evenOdd = b_all_evenOdd(1:N); 
x_evenOdd=pinv(A_train_evenOdd)*b_train_evenOdd; 
A_test_evenOdd = A_all_evenOdd(N+1:10*N,:); 
b_test_evenOdd = b_all_evenOdd(N+1:10*N); 

A_train_EvenIs4 = A_all_EvenIs4(1:N,:); 
b_train_EvenIs4 = b_all_EvenIs4(1:N); 
x_EvenIs4=pinv(A_train_EvenIs4)*b_train_EvenIs4; 
A_test_EvenIs4 = A_all_EvenIs4(N+1:5*N,:); 
b_test_EvenIs4 = b_all_EvenIs4(N+1:5*N); 

A_train_OddIs5 = A_all_OddIs5(1:N,:); 
b_train_OddIs5 = b_all_OddIs5(1:N); 
x_OddIs5=pinv(A_train_OddIs5)*b_train_OddIs5; 
A_test_OddIs5 = A_all_OddIs5(N+1:5*N,:); 
b_test_OddIs5 = b_all_OddIs5(N+1:5*N); 

A_train_02or68 = A_all_02or68(1:N,:); 
b_train_02or68 = b_all_02or68(1:N); 
x_02or68=pinv(A_train_02or68)*b_train_02or68; 
A_test_02or68 = A_all_02or68(N+1:4*N,:); 
b_test_02or68 = b_all_02or68(N+1:4*N); 

A_train_13or79 = A_all_13or79(1:N,:); 
b_train_13or79 = b_all_13or79(1:N); 
x_13or79=pinv(A_train_13or79)*b_train_13or79; 
A_test_13or79 = A_all_13or79(N+1:4*N,:); 
b_test_13or79 = b_all_13or79(N+1:4*N); 

A_train_0or2 = A_all_0or2(1:N,:); 
b_train_0or2 = b_all_0or2(1:N); 
x_0or2=pinv(A_train_0or2)*b_train_0or2; 
A_test_0or2 = A_all_0or2(N+1:2*N,:); 
b_test_0or2 = b_all_0or2(N+1:2*N); 

A_train_6or8 = A_all_6or8(1:N,:); 
b_train_6or8 = b_all_6or8(1:N); 
x_6or8=pinv(A_train_6or8)*b_train_6or8; 
A_test_6or8 = A_all_6or8(N+1:2*N,:); 
b_test_6or8 = b_all_6or8(N+1:2*N); 

A_train_1or3 = A_all_1or3(1:N,:); 
b_train_1or3 = b_all_1or3(1:N); 
x_1or3=pinv(A_train_1or3)*b_train_1or3; 
A_test_1or3 = A_all_1or3(N+1:2*N,:); 
b_test_1or3 = b_all_1or3(N+1:2*N); 

A_train_7or9 = A_all_7or9(1:N,:); 
b_train_7or9 = b_all_7or9(1:N); 
x_7or9=pinv(A_train_7or9)*b_train_7or9; 
A_test_7or9 = A_all_7or9(N+1:2*N,:); 
b_test_7or9 = b_all_7or9(N+1:2*N); 


%% ===================== Check Performance ===========================

pred_evenOdd = sign(A_train_evenOdd*x_evenOdd);
final_pred = zeros(N,1);
% the vector which has the right values
TrueC = zeros(N,1);
for i=1:N/10
    TrueC(10*i-9)   = 0;
    TrueC(10*i-8)   = 1;
    TrueC(10*i-7)   = 2;
    TrueC(10*i-6)   = 3;
    TrueC(10*i-5)   = 4;
    TrueC(10*i-4)   = 5;
    TrueC(10*i-3)   = 6;
    TrueC(10*i-2)   = 7;
    TrueC(10*i-1)   = 8;
    TrueC(10*i)   = 9;
end

for i = 1:N
   curr = A_train_evenOdd(i,:); % current image in row vector
   if( pred_evenOdd(i,1) == 1) % Even Case
        if ( sign(curr*x_EvenIs4) == 1) % is 4
            final_pred(i,1) = 4;
        else
            is02or68 = curr*x_02or68;
            is0or2 = curr*x_0or2;
            is6or8 = curr*x_6or8;
            if( sign(is02or68) == -1 ) % Is 0 or 2
               if(sign(is0or2) == -1) % Is 0
                   final_pred(i,1) = 0;
               else % Is 2
                   final_pred(i,1) = 2;
               end
            else  % Is 6 or 8
                if(sign(is6or8) == -1) % Is 6
                   final_pred(i,1) = 6;
               else % Is 8
                   final_pred(i,1) = 8;
                end 
            end
        end 
   else % Odd Case
       if ( sign(curr*x_OddIs5) == 1) % is 5
            final_pred(i,1) = 5;
       else
            is13or79 = curr*x_13or79;
            is1or3 = curr*x_1or3;
            is7or9 = curr*x_7or9;
            if( sign(is13or79) == -1 ) % Is 1 or 3
               if(sign(is1or3) == -1) % Is 1
                   final_pred(i,1) = 1;
               else % Is 3
                   final_pred(i,1) = 3;
               end
            else  % Is 7 or 9
                if(sign(is7or9) == -1) % Is 7
                   final_pred(i,1) = 7;
               else % Is 9
                   final_pred(i,1) = 9;
                end 
            end
        end 
   end  % End of Odd Case
   
end

disp('Train Error:'); 
acc=mean(final_pred == TrueC)*100;
disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 


%% ================= Show the Problematric Images ====================






	