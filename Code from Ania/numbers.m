function y = numbers(img)
%� ����� ���������� �������� (������������� ���� ������ �������)
%����� ����� ����������� ��� ���� �������� ����� �������� �� ���������.
%�.�. ��������� ����� ������ � ���� ���������� �������� �� ���������, 
%�������� �� ���� � ��� ������, ��� ���� �������. ������ � ����� �����
%��������� � ���� ��������������.

img_sum= sum(img);
%img_sum = smothing(img_sum, 10);
m = mean(img_sum(:));

figure(5)
subplot(2,1,1)
imshow(img);
%plot(img_sum)

for i = 1:size(img_sum,2)
    if img_sum(i) <= 1
       img_sum(i) = 0;
    end
end
subplot(2,1,2)
plot(img_sum,'r');
hold on;

s = size(img_sum);
index = 1;
for i = 2:s(2)-1
    if img_sum(i) == 0 && img_sum(i-1)> 0 %&& img_sum(i) <= m
        index = [index i];
    end
    
    if img_sum(i) == 0 && img_sum(i+1)> 0 %&& img_sum(i) <= m
        index = [index i];
    end
end

plot(index,img_sum(index),'*');
%plot(1:s(2),mean(img_sum));
hold off
%new_index = index(1, 3:end);%2 and 3 are equal!

%!!!���� �������������, ����� ������� �� �����������
%p = 1;
%for i = 2:size(index,2)-1
    %if index(i) == index(i-1)
        %new_index = index(i-1 i+1);
        
    %end 
%end


y=index;
end

