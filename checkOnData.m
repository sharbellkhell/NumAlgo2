

function [pred_train_is] = checkOnData(digit, N, A_train_is, b_train_is, A_test_is, b_test_is, x_is)
    % Check on training data
    pred_train_is = sign(A_train_is*x_is);
    disp(['Train Error in digit ',num2str(digit),':' ]); 
    acc=mean(pred_train_is == b_train_is)*100;
    disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 
    % Check on testing data
    pred_test_is = sign(A_test_is*x_is);
    disp(['Test Error in digit ',num2str(digit),':' ]); 
    acc=mean(pred_test_is == b_test_is)*100;
    disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 
end