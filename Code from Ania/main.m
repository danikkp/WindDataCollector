clear all
clc
close all

%������������� �������� � ��� �����.
%1. ��������� �������� ��� �������������
%2. ����������� � ���������� ��������. �� ������ ����� ����� 
%   �������� "�������������" �������, ������� ����� ����� 
%   ������������ � "��������" (���������) ����
%3. ��������� ���������������� �������� � ���������.


img = imread('1.jpg');
[m n k] = size(img);
imshow(img)

%allocation of needed area
%c = getrect
c = [1738 222 440 1212];
img2 = img(c(2):c(2)+c(4), c(1):c(1)+c(3), :);
%imshow(img2);

%to show edges
BW = edge(img2(:,:,1),'log');
%figure(1)
%imshow(BW)

index_y = windows_9(BW);%��������� 9 ������ �� y
plot_int(BW,index_y);% ��������� 9 ���������� ������ �� ����� ������. 
%��������������� �������
hold off

%�-���������� �������. ���� ������ ����� �-����������.
%(������� �����������)
%� ������������� ��� ��� ������ ��� �������� �������� 
%���������� �������. ��� ������ ������ ����� �������� ���������,
%��� �������� ���� � ��� ����������� ������������� ��� ���� 9 ������
%��������
ind1 = 16;
ind2 = 17;
%��������� ������������� ��������������� ��������, � ������� ����� ����
%������ ������� img_2
img_2 = BW(index_y(ind1):index_y(ind2),:,:);%�� �
index_x = numbers(img_2);%����� ������� ��� ������� �� �.
%����� ������������ �������. ���� ���������� ������ ��� �����, 
%� ��� �����
index_y_n = [index_y(ind1) index_y(ind2)];%�����: ������ ��� ����������� ������ �������
y = detection3(BW,index_x,index_y_n)%����� ���������� �����



%������ ���� ����� ��� ��� ������� � ������ ���������� � ���������� �
%��������� ����. ���� ��� ������ ���������, �� ����� ����� ������ �� ������






    
    
