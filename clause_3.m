%% ====================== Prepare New Test Set ======================
load('mnist.mat');

num_images = test.count;
new_test_images = shiftdim(test.images, 2);
A_new_test = reshape(new_test_images,num_images,28*28);
A_new_test = [A_new_test, ones(num_images,1)];
true_labels = test.labels;

%% ============================ Predict ==============================
UNCLASSIFIED = -1;
pred = UNCLASSIFIED * ones(num_images, 1);

% TODO: compute your predictions

% Import the 10 identifiers from clause_2:

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

[A_all_is0, b_all_is0] = CreateAB(0,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is1, b_all_is1] = CreateAB(1,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is2, b_all_is2] = CreateAB(2,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is3, b_all_is3] = CreateAB(3,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is4, b_all_is4] = CreateAB(4,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is5, b_all_is5] = CreateAB(5,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is6, b_all_is6] = CreateAB(6,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is7, b_all_is7] = CreateAB(7,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is8, b_all_is8] = CreateAB(8,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);
[A_all_is9, b_all_is9] = CreateAB(9,N,imagesPerDigit0,imagesPerDigit1,imagesPerDigit2,imagesPerDigit3,imagesPerDigit4,imagesPerDigit5,imagesPerDigit6,imagesPerDigit7,imagesPerDigit8,imagesPerDigit9);

[x_is0] = SolveLSClause3(N,A_all_is0,b_all_is0);
[x_is1] = SolveLSClause3(N,A_all_is1,b_all_is1);
[x_is2] = SolveLSClause3(N,A_all_is2,b_all_is2);
[x_is3] = SolveLSClause3(N,A_all_is3,b_all_is3);
[x_is4] = SolveLSClause3(N,A_all_is4,b_all_is4);
[x_is5] = SolveLSClause3(N,A_all_is5,b_all_is5);
[x_is6] = SolveLSClause3(N,A_all_is6,b_all_is6);
[x_is7] = SolveLSClause3(N,A_all_is7,b_all_is7);
[x_is8] = SolveLSClause3(N,A_all_is8,b_all_is8);
[x_is9] = SolveLSClause3(N,A_all_is9,b_all_is9);

pred_is0 = A_new_test*x_is0;
pred_is1 = A_new_test*x_is1;
pred_is2 = A_new_test*x_is2;
pred_is3 = A_new_test*x_is3;
pred_is4 = A_new_test*x_is4;
pred_is5 = A_new_test*x_is5;
pred_is6 = A_new_test*x_is6;
pred_is7 = A_new_test*x_is7;
pred_is8 = A_new_test*x_is8;
pred_is9 = A_new_test*x_is9;

% The way the following code works is by taking every single image
% and comparing the values we got in each of the 10 identifiers
% and the identifier with the maxmium positive value is chosen
% this algorithm is hugely inefficent, and there is lots of room for
% optimization, down from 10 comparisons per digit to log_2^10 comparisons,
% one possible way is simmilar to the way merge sort works
% where we "slice" every problem in half:
% if digit is smaller than 5 --> if digit is smaller than 2 ... and so on
% (i wrote the code for it found in file called Extra.m)

for i = 1:num_images
 currentDigitPred  = 0;
 currentMaxPred = pred_is0(i);
 if (pred_is1(i) > currentMaxPred)
   currentDigitPred  = 1;
   currentMaxPred = pred_is1(i);  
 end
 if (pred_is2(i) > currentMaxPred)
   currentDigitPred  = 2;
   currentMaxPred = pred_is2(i);  
 end
 if (pred_is3(i) > currentMaxPred)
   currentDigitPred  = 3;
   currentMaxPred = pred_is3(i);  
 end
 if (pred_is4(i) > currentMaxPred)
   currentDigitPred  = 4;
   currentMaxPred = pred_is4(i);  
 end
 if (pred_is5(i) > currentMaxPred)
   currentDigitPred  = 5;
   currentMaxPred = pred_is5(i);  
 end
 if (pred_is6(i) > currentMaxPred)
   currentDigitPred  = 6;
   currentMaxPred = pred_is6(i);  
 end
 if (pred_is7(i) > currentMaxPred)
   currentDigitPred  = 7;
   currentMaxPred = pred_is7(i);  
 end
 if (pred_is8(i) > currentMaxPred)
   currentDigitPred  = 8;
   currentMaxPred = pred_is8(i);  
 end
 if (pred_is9(i) > currentMaxPred)
   currentDigitPred  = 9;
   currentMaxPred = pred_is9(i);  
 end
 pred(i) = currentDigitPred;
end


%% =========================== Evaluate ==============================
acc = mean(pred == true_labels)*100;
disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*num_images),' wrong examples)']); 