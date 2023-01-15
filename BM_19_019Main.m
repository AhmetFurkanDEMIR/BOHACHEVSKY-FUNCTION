
%Sentetik veri seti üretelim

veriSeti_in = randi([-100 100],125,2);
d = length(veriSeti_in);

veriSeti_out=[];

for ii = 1:(d)
    x1 = veriSeti_in(ii);
    x2 = veriSeti_in(ii+1);


    term1 = x1^2;
    term2 = 2*x2^2;
    term3 = -0.3 * cos(3*pi*x1);
    term4 = -0.4 * cos(4*pi*x2);

    y = term1 + term2 + term3 + term4 + 0.7;


    veriSeti_out = [veriSeti_out, y];
end

New_veriSeti_out = transpose(veriSeti_out);

VS=[veriSeti_in New_veriSeti_out];

egt=VS(1:75,:);
test=VS(76:125,:);

%Veri setinin rasgele olarak %75eðitim kümesine, %25 test kümesine atanýr
%Hiper paramtre deðerleri atanýyor
pop_uz=5;
pc=5;
pm=0.001;
% Her bir Kromozom reel sayýlar kullanýlarak kodlanacak
%Her bir deðiþkenin deðiþim aralýðý [-100 100] olarak kabul ediyoruz.
%kromozomdaki gen sayisi 2 girdili ve 4 dilsel deger kabul edilir
%Her bir dilsel deðerin GaussMf ile temsil edildiði kabul edildi. bu göre
%kromozom boyutu 64 olarak hesaplandi. 5 bireyli bir populasyon üretildi
pop=randi([-100 100],pop_uz,64); %baslangýc populasyonu oluþturuldu.
%tempfis=readfis(mainFis);

fitness_mseList = [];

tempfis = readfis("/home/demir/Desktop/dersler/bulanıkMantık/BS_19_019/BM_19_019MyFis.fis");

% Egt 1
for i=1:5
    % Kuralýn öncül kýsýmlarý(premise part)
    tempfis.input(1,1).mf(1,1).params=pop(i,1:2); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,2).params=pop(i,3:4); %X deðiþkenine ait A2 dilsel deðeri
    tempfis.input(1,1).mf(1,3).params=pop(i,5:6); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,4).params=pop(i,7:8); %X deðiþkenine ait A2 dilsel deðeri

     
    tempfis.input(1,2).mf(1,1).params=pop(i,9:10); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,2).params=pop(i,11:12); %y deðiþkenine ait B2 dilsel deðeri
    tempfis.input(1,2).mf(1,3).params=pop(i,13:14); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,4).params=pop(i,15:16); %y deðiþkenine ait B2 dilsel deðeri

    %Kuralýn soncul kýsmý:(lineer olarak kodlanan kýsmý pi,qi ve ri
    tempfis.output.mf(1,1).params=pop(i,17:19); % p1,q1,r1
    tempfis.output.mf(1,2).params=pop(i,20:22); %p2,q2,r2
    tempfis.output.mf(1,3).params=pop(i,23:25); %p3, q3, r3
    tempfis.output.mf(1,4).params=pop(i,26:28); % p4, q4, r4
    tempfis.output.mf(1,5).params=pop(i,29:31); % p1,q1,r1
    tempfis.output.mf(1,6).params=pop(i,32:34); %p2,q2,r2
    tempfis.output.mf(1,7).params=pop(i,35:37); %p3, q3, r3
    tempfis.output.mf(1,8).params=pop(i,38:40); % p4, q4, r4
    tempfis.output.mf(1,9).params=pop(i,41:43); % p1,q1,r1
    tempfis.output.mf(1,10).params=pop(i,44:46); %p2,q2,r2
    tempfis.output.mf(1,11).params=pop(i,47:49); %p3, q3, r3
    tempfis.output.mf(1,12).params=pop(i,50:52); % p4, q4, r4
    tempfis.output.mf(1,13).params=pop(i,53:55); % p1,q1,r1
    tempfis.output.mf(1,14).params=pop(i,56:58); %p2,q2,r2
    tempfis.output.mf(1,15).params=pop(i,59:61); %p3, q3, r3
    tempfis.output.mf(1,16).params=pop(i,62:64); % p4, q4, r4
    
    hesaplan_cikis= evalfis(egt(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1));
    fitness_mseList = [fitness_mseList, sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1))];
end;

% Egt 2
% caprazlanmis ve iki defa mutasyona ugramis yeni populasyon
pop = xlsread("/home/demir/Desktop/dersler/bulanıkMantık/BS_19_019/BM_19_019NewPop.xlsx");
for i=1:5
    % Kuralýn öncül kýsýmlarý(premise part)
    tempfis.input(1,1).mf(1,1).params=pop(i,1:2); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,2).params=pop(i,3:4); %X deðiþkenine ait A2 dilsel deðeri
    tempfis.input(1,1).mf(1,3).params=pop(i,5:6); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,4).params=pop(i,7:8); %X deðiþkenine ait A2 dilsel deðeri

     
    tempfis.input(1,2).mf(1,1).params=pop(i,9:10); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,2).params=pop(i,11:12); %y deðiþkenine ait B2 dilsel deðeri
    tempfis.input(1,2).mf(1,3).params=pop(i,13:14); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,4).params=pop(i,15:16); %y deðiþkenine ait B2 dilsel deðeri

    %Kuralýn soncul kýsmý:(lineer olarak kodlanan kýsmý pi,qi ve ri
    tempfis.output.mf(1,1).params=pop(i,17:19); % p1,q1,r1
    tempfis.output.mf(1,2).params=pop(i,20:22); %p2,q2,r2
    tempfis.output.mf(1,3).params=pop(i,23:25); %p3, q3, r3
    tempfis.output.mf(1,4).params=pop(i,26:28); % p4, q4, r4
    tempfis.output.mf(1,5).params=pop(i,29:31); % p1,q1,r1
    tempfis.output.mf(1,6).params=pop(i,32:34); %p2,q2,r2
    tempfis.output.mf(1,7).params=pop(i,35:37); %p3, q3, r3
    tempfis.output.mf(1,8).params=pop(i,38:40); % p4, q4, r4
    tempfis.output.mf(1,9).params=pop(i,41:43); % p1,q1,r1
    tempfis.output.mf(1,10).params=pop(i,44:46); %p2,q2,r2
    tempfis.output.mf(1,11).params=pop(i,47:49); %p3, q3, r3
    tempfis.output.mf(1,12).params=pop(i,50:52); % p4, q4, r4
    tempfis.output.mf(1,13).params=pop(i,53:55); % p1,q1,r1
    tempfis.output.mf(1,14).params=pop(i,56:58); %p2,q2,r2
    tempfis.output.mf(1,15).params=pop(i,59:61); %p3, q3, r3
    tempfis.output.mf(1,16).params=pop(i,62:64); % p4, q4, r4
    
    hesaplan_cikis= evalfis(egt(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1));
    fitness_mseList = [fitness_mseList, sum((egt(:,3)-hesaplan_cikis).^2)/length(egt(:,1))];
end;


% Test MyFis

for i=1:5
    % Kuralýn öncül kýsýmlarý(premise part)
    tempfis.input(1,1).mf(1,1).params=pop(i,1:2); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,2).params=pop(i,3:4); %X deðiþkenine ait A2 dilsel deðeri
    tempfis.input(1,1).mf(1,3).params=pop(i,5:6); %X deðiþkenine ait A1 dilsel deðeri
    tempfis.input(1,1).mf(1,4).params=pop(i,7:8); %X deðiþkenine ait A2 dilsel deðeri

     
    tempfis.input(1,2).mf(1,1).params=pop(i,9:10); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,2).params=pop(i,11:12); %y deðiþkenine ait B2 dilsel deðeri
    tempfis.input(1,2).mf(1,3).params=pop(i,13:14); %Y deðiþkenine ait B1 dilsel deðeri
    tempfis.input(1,2).mf(1,4).params=pop(i,15:16); %y deðiþkenine ait B2 dilsel deðeri

    %Kuralýn soncul kýsmý:(lineer olarak kodlanan kýsmý pi,qi ve ri
    tempfis.output.mf(1,1).params=pop(i,17:19); % p1,q1,r1
    tempfis.output.mf(1,2).params=pop(i,20:22); %p2,q2,r2
    tempfis.output.mf(1,3).params=pop(i,23:25); %p3, q3, r3
    tempfis.output.mf(1,4).params=pop(i,26:28); % p4, q4, r4
    tempfis.output.mf(1,5).params=pop(i,29:31); % p1,q1,r1
    tempfis.output.mf(1,6).params=pop(i,32:34); %p2,q2,r2
    tempfis.output.mf(1,7).params=pop(i,35:37); %p3, q3, r3
    tempfis.output.mf(1,8).params=pop(i,38:40); % p4, q4, r4
    tempfis.output.mf(1,9).params=pop(i,41:43); % p1,q1,r1
    tempfis.output.mf(1,10).params=pop(i,44:46); %p2,q2,r2
    tempfis.output.mf(1,11).params=pop(i,47:49); %p3, q3, r3
    tempfis.output.mf(1,12).params=pop(i,50:52); % p4, q4, r4
    tempfis.output.mf(1,13).params=pop(i,53:55); % p1,q1,r1
    tempfis.output.mf(1,14).params=pop(i,56:58); %p2,q2,r2
    tempfis.output.mf(1,15).params=pop(i,59:61); %p3, q3, r3
    tempfis.output.mf(1,16).params=pop(i,62:64); % p4, q4, r4
    
    hesaplan_cikis= evalfis(test(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1));
    fitness_mseList = [fitness_mseList, sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1))];
end;

% Test AnfisToolbox

% egitilmis fis
tempfis = readfis("/home/demir/Desktop/dersler/bulanıkMantık/BS_19_019/BM_19_019Anfis.fis");

for i=1:5

    
    hesaplan_cikis= evalfis(test(:,1:2),tempfis);
    %MSE hesaplayacagým
    fitness_mse(i,1)=sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1));
    fitness_mseList = [fitness_mseList, sum((test(:,3)-hesaplan_cikis).^2)/length(test(:,1))];
end;

%çaprazlama ve mutasyon

% BM_19_019CaprazlamaMutasyonKodu klasoru icersinde python ile yazdım
% BM_19_019Kromozom.xlsx adlı exel dosyasında da yaptım