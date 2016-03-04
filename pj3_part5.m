%opts = struct('iter',200);
%size = size(R);
%predictedR = zeros(size(1), size(2));
%for i = 1:10
%    word=sprintf('fold %0.0d. \n ',i);
%    disp(word);
%    temp = test{i};
%    tempR = R;
%    for j = 1:10000
%        tempR(u(temp(j), 1), u(temp(j), 2)) = nan;
%    end
%    predict = pj3_part42(tempR, 100, 1, opts); % you can change k here
%    for j = 1:10000
%        user = u(temp(j), 1);
%        movie = u(temp(j), 2);
%        predictedR(user, movie) = predict(user, movie);
%    end
%end
testR = R;
W=isnan(predictedR);
predictedR(W)=0;
W=isnan(testR);
testR(W)=0;
percentage = 0;
   for j = 1:size(1)
        prerow = predictedR(j,:);
        [presorted, presortedindex] = sort(prerow, 'descend');
        %actrow = testR(j,:);
        %[actsorted, actsortedindex] = sort(actrow, 'descend');
        %acttopfive = actsortedindex(1:5);
        pretopfive = presortedindex(1:5);
        hit = 0;
        for k = 1:5
            if R(j, pretopfive(k)) > 3
                hit = hit + 1;
            end
        end
        percentage = percentage + hit / 5;
        %hit = 0;
        %for i = 1:5
        %    if ismember(acttopfive, presortedindex(i))
        %        hit = hit + 1;
        %    end
        %end
        %percentage = percentage + hit / 5;
   end
   averprecision = percentage / size(1); 