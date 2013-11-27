function y = windows_9(BW)
%выделение 9 черных областей для анализа

%plot with searching for "spaces with numbers "
for_plot1 = sum(BW');
%figure(3)
%hold on;
%title('for Spaces')

%СГЛАЖИВАНИЕ
for_plot1 = smothing(for_plot1, 10);
s = size(for_plot1);
%plot(for_plot1,'r');
%сглаживание делаю для того, чтобы было легче выделять пики. 
%Пики наблюдаются "пустотах" мужду черными областями с цифрами
%note! возможно, эта функция и не так важна, но с ней проще выделять пики и
%и применять дальнейшую логику.

% вот тут проверять, что бы всего было индексов 19!!!
t = 50;%!!! написать автоматический поиск этого значения, 
%основываясь на том, что всего 19 точек пересечения прямой 
%и большой гистограммы.
%plot(1:s(2),t)

%УБОРКА ВСЕГО, ЧТО НИЖЕ t
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
%теперь у меня есть интервалы. 2-3 4-5 6-7 и тд.

y = index;
end

