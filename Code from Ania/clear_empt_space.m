function  y = clear_empt_space(img)
%чистит пустые полоски из клеток по у и х
[m n] = size(img);

% по у
ind = 0;
ind2 = 0;
for i = 1:m
    line = zeros(1,n);
    if img(i,:) == line
       ind = [ind i];
    else
       ind2 = [ind2 i];
    end
end

ind_for_acc = ind2(2:end);
%new_img = img(ind_for_acc,:,:);

%по х
ind_x = 0;
ind2_x = 0;
for i = 1:n
    line = zeros(1,m);
    if img(:,i) == line'
       ind_x = [ind_x i];
    else
       ind2_x = [ind2_x i];
    end
end

ind_for_acc_x = ind2_x(2:end);
new_img = img(ind_for_acc,ind_for_acc_x,:);

y = new_img;
end

