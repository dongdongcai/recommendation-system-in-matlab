error = zeros(1, 10);
for i = 1:10
    word=sprintf('fold %0.0d. \n ',i);
    disp(word);
    temp = test{i};
    testpart = [];
    for j = 1:10000
        testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
    end
    thiserror = factofor10fold(R,100,testpart); %you can change k here
    error(i) = thiserror;
end
aver = sum(error) / 10;