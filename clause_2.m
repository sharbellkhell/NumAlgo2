% clc; clear;


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

%% ========================= Solve LS ==============================

[A_train_is0, b_train_is0, A_test_is0, b_test_is0, x_is0] = SolveLS(N, 10,A_all_is0,b_all_is0);
[A_train_is1, b_train_is1, A_test_is1, b_test_is1, x_is1] = SolveLS(N, 10,A_all_is1,b_all_is1);
[A_train_is2, b_train_is2, A_test_is2, b_test_is2, x_is2] = SolveLS(N, 10,A_all_is2,b_all_is2);
[A_train_is3, b_train_is3, A_test_is3, b_test_is3, x_is3] = SolveLS(N, 10,A_all_is3,b_all_is3);
[A_train_is4, b_train_is4, A_test_is4, b_test_is4, x_is4] = SolveLS(N, 10,A_all_is4,b_all_is4);
[A_train_is5, b_train_is5, A_test_is5, b_test_is5, x_is5] = SolveLS(N, 10,A_all_is5,b_all_is5);
[A_train_is6, b_train_is6, A_test_is6, b_test_is6, x_is6] = SolveLS(N, 10,A_all_is6,b_all_is6);
[A_train_is7, b_train_is7, A_test_is7, b_test_is7, x_is7] = SolveLS(N, 10,A_all_is7,b_all_is7);
[A_train_is8, b_train_is8, A_test_is8, b_test_is8, x_is8] = SolveLS(N, 10,A_all_is8,b_all_is8);
[A_train_is9, b_train_is9, A_test_is9, b_test_is9, x_is9] = SolveLS(N, 10,A_all_is9,b_all_is9);


%% ===================== Check Performance ===========================

[pred_train_is0] = checkOnData(0,N, A_train_is0, b_train_is0, A_test_is0, b_test_is0, x_is0);
[pred_train_is1] = checkOnData(1,N, A_train_is1, b_train_is1, A_test_is1, b_test_is1, x_is1);
[pred_train_is2] = checkOnData(2,N, A_train_is2, b_train_is2, A_test_is2, b_test_is2, x_is2);
[pred_train_is3] = checkOnData(3,N, A_train_is3, b_train_is3, A_test_is3, b_test_is3, x_is3);
[pred_train_is4] = checkOnData(4,N, A_train_is4, b_train_is4, A_test_is4, b_test_is4, x_is4);
[pred_train_is5] = checkOnData(5,N, A_train_is5, b_train_is5, A_test_is5, b_test_is5, x_is5);
[pred_train_is6] = checkOnData(6,N, A_train_is6, b_train_is6, A_test_is6, b_test_is6, x_is6);
[pred_train_is7] = checkOnData(7,N, A_train_is7, b_train_is7, A_test_is7, b_test_is7, x_is7);
[pred_train_is8] = checkOnData(8,N, A_train_is8, b_train_is8, A_test_is8, b_test_is8, x_is8);
[pred_train_is9] = checkOnData(9,N, A_train_is9, b_train_is9, A_test_is9, b_test_is9, x_is9);


%% ================= Show the Problematric Images ====================

PrintOnePicture(pred_train_is0,b_train_is0,A_train_is0,x_is0);
PrintOnePicture(pred_train_is1,b_train_is1,A_train_is1,x_is1);
PrintOnePicture(pred_train_is2,b_train_is2,A_train_is2,x_is2);
PrintOnePicture(pred_train_is3,b_train_is3,A_train_is3,x_is3);
PrintOnePicture(pred_train_is4,b_train_is4,A_train_is4,x_is4);
PrintOnePicture(pred_train_is5,b_train_is5,A_train_is5,x_is5);
PrintOnePicture(pred_train_is6,b_train_is6,A_train_is6,x_is6);
PrintOnePicture(pred_train_is7,b_train_is7,A_train_is7,x_is7);
PrintOnePicture(pred_train_is8,b_train_is8,A_train_is8,x_is8);
PrintOnePicture(pred_train_is9,b_train_is9,A_train_is9,x_is9);









