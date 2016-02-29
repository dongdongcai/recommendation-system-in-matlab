size = size(R);
predictedR = zeros(size(1), size(2));
for i = 1:10
    word=sprintf('fold %0.0d. \n ',i);
    disp(word);
    temp = test{i};
    testpart = [];
    for j = 1:10000
        testpart = [testpart ;{u(temp(j), 1), u(temp(j), 2)}];
    end
    predict = pj3_part4(R,100); % you can change k here
    for j = 1:10000
        user = u(temp(j), 1);
        movie = u(temp(j), 2);
        predictedR(user, movie) = predict(user, movie);
    end
end
percentage = 0;
   for j = 1:size(1)
        prerow = predict(j,:);
        [presorted, presortedindex] = sort(row, 'descend');
        actrow = R(j,:);
        [actsorted, actsortedindex] = sort(actrow, 'descend');
        acttopfive = actsortedindex(1:5);
        hit = 0;
        for i = 1:5
            if ismember(acttopfive, presortedindex(i))
                hit = hit + 1;
            end
        end
        percentage = percentage + hit / 5;
   end
   averprecision = percentage / size(1); 