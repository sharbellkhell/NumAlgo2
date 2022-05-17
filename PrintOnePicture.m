function [] = PrintOnePicture(pred_train_is,b_train_is,A_train_is,x_is)
    error = find(pred_train_is~=b_train_is);
    figure(2);
    imagesc(reshape(A_train_is(error(1),1:28^2),[28,28]));
    colormap(gray(256))
    axis image; axis off; 
    title(['problematic digit number ',num2str(1),' :',num2str(A_train_is(error(1),:)*x_is)]); 
end