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
total = 0;
hitpercentage = [];
falsepercentage = []
for L = 1:size(2)
    hit = 0;
   for j = 1:size(1)
        prerow = predict(j,:);
        [presorted, presortedindex] = sort(row, 'descend');
        actrow = R(j,:);
        [actsorted, actsortedindex] = sort(actrow, 'descend');
        total = total + sum(actrow~=0,2);
        acttopfive = actsortedindex(1:L);
        for i = 1:L
            if ismember(acttopfive, presortedindex(i))
                hit = hit + 1;
            end
        end
   end
   if total < L * size(1)
        break;
   end
   hitpercentage = [hitpercentage, hit / L * size(1)];
   falsepercentage = [falsepercentage, (L * size(1) - hit) / (total - L * size(1))];
end
plot(falsepercentage, hitpercentage, '+');
xlabel(falserate);
ylabel(hitrate);