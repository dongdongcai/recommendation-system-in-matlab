error = zeros(1, 10);
for i = 1:10
    tempR = R;
    word=sprintf('fold %0.0d. \n ',i);
    disp(word);
    temp = test{i};
    testpart = [];
    %testmatrix = zeros(943, 1682);
    for j = 1:10000
        testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
        tempR(u(temp(j), 1), u(temp(j), 2)) = nan;
        %tempR(u(j, 1), u(j, 2)) = nan;
        %testmatrix(u(temp(j), 1), u(temp(j), 2)) = 1;
    end
    thiserror = factofor10fold(R,100,testpart); %you can change k here
    %[A, Y] = wnmfrule(tempR, 100);
    %thiserror = sum(sum(testmatrix .* abs(A * Y - testR)));
    error(i) = thiserror;
end
aver = sum(error) / 10;