function y = windows_9(BW)
%��������� 9 ������ �������� ��� �������

%plot with searching for "spaces with numbers "
for_plot1 = sum(BW');
%figure(3)
%hold on;
%title('for Spaces')

%�����������
for_plot1 = smothing(for_plot1, 10);
s = size(for_plot1);
%plot(for_plot1,'r');
%����������� ����� ��� ����, ����� ���� ����� �������� ����. 
%���� ����������� "��������" ����� ������� ��������� � �������
%note! ��������, ��� ������� � �� ��� �����, �� � ��� ����� �������� ���� �
%� ��������� ���������� ������.

% ��� ��� ���������, ��� �� ����� ���� �������� 19!!!
t = 50;%!!! �������� �������������� ����� ����� ��������, 
%����������� �� ���, ��� ����� 19 ����� ����������� ������ 
%� ������� �����������.
%plot(1:s(2),t)

%������ �����, ��� ���� t
for i = 1:s(2)
    if for_plot1(i) <= t
        for_plot1(i) = t;
    end
end

index = 1;
for i = 2:s(2)-1
    if for_plot1(i) == 50 && for_plot1(i-1)> 50
        index = [index i];
    end
    
    if for_plot1(i) == 50 && for_plot1(i+1)> 50
        index = [index i];
    end
end

%plot(index,for_plot1(index),'*')
index;
%[Y, index] = sort(index);
%index
%������ � ���� ���� ���������. 2-3 4-5 6-7 � ��.

y = index;
end

