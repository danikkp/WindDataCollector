function y = plot_int(BW, index )
%функция рисования 9 областей
%BW - все изображение
%index - индексы по y. Они отражают у-координату наших 
%        черных необходымых областей с цифрами на картинке 

figure(34)
subplot(3,3,1)
img_1 = BW(index(2):index(3),:,:);
imshow(img_1)

subplot(3,3,2)
img_2 = BW(index(4):index(5),:,:);
imshow(img_2)

subplot(3,3,3)
img_3 = BW(index(6):index(7),:,:);
imshow(img_3)

subplot(3,3,4)
img_4 = BW(index(8):index(9),:,:);
imshow(img_4)

subplot(3,3,5)
img_5 = BW(index(10):index(11),:,:);
imshow(img_5)

subplot(3,3,6)
img_6 = BW(index(12):index(13),:,:);
imshow(img_6)

subplot(3,3,7)
img_7 = BW(index(14):index(15),:,:);
imshow(img_7)

subplot(3,3,8)
img_8 = BW(index(16):index(17),:,:);
imshow(img_8)

subplot(3,3,9)
img_9 = BW(index(18):index(19),:,:);
imshow(img_9)

y = 1;

end

