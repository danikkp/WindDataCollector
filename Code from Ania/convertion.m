function y = convertion(index)

new_index = index(2:end);
[m n] = size(new_index);

if new_index(2) <=10
    new_index(2) = 14;
end


a = '0'; %%%%changed here to string
for i = 1:n
    if new_index(i) <= 9 % цифры
        a = [a int2str(new_index(i))]; %%%%int2str added
    elseif new_index(i) == 10 % 0
        a = [a '0'];
    elseif new_index(i) == 11% почему-то не всегда работает. Что не так?
        %a = [a '.'];
    end
end

y = a(2:end);
end

