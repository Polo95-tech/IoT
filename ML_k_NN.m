% Marco Döhring
% Matrikel-Nr.: 10052723
% Praktikumsaufgabe 2
% k_Nearst Neighbour Algorithmus

%Einlesen der Testdaten mit relevanten Merkmalen
clear all;
close all;
%close all
load fisheriris
X = meas(:,3:4);
%Erzeugen des Diagramm mit Testdaten
figure;
title 'Iris Daten'
xlabel 'Länge Blütenblatt in cm';
ylabel 'Breite Blütenblatt in cm';
hold on;
plot(X(:,1),X(:,2),'k*','Markersize',5);
plot(X(51:100,1),X(51:100,2),'r*','MarkerSize',5);
plot(X(101:150,1),X(101:150,2),'g*','MarkerSize',5);
legend('Iris setosa','Iris versicolor','Iris virginica','Location','best');
%mit hold on weitere plot Befehle zu dem aktuellen Diagramm einfügen
hold on;
%Wahl der Anzahl an zu wählenden Nachbarn für den Algorithmus
k=7;
%Input werte in x-& y-Koordinaten aufteilen
x=(X(:,1));
y=(X(:,2));
anzahlwerte = length(x);
%Angebenen neuen Punkte 
PX = [2.5 0.75; 5 1.5; 6 1.75];
%Anzahl der neuen Messpunkte
anzahl_dp = 3;
%Startpunkte sidn die neuen Messpunkte in x/y Koordinaten aufgeteilt
startcentx=rand(3,1);
startcenty=rand(3,1);
for i=1:anzahl_dp,
    startcentx(i)= PX(i,1);
    startcenty(i)= PX(i,2);
end
%for i=1:anzahl_dp,
%    startcentx(i) = PX(0,0
%Distanzmatrix der Größe Anzahl der Werte für 3 Datenpunkte
distanz=rand(anzahlwerte,anzahl_dp);
%Bestimmen der Distanzen durch Vorgabe euklidische Distanz
for i=1:anzahl_dp,
    for j=1:anzahlwerte,
        distanz(j,i)=((x(j)-startcentx(i))^2)+((y(j)-startcenty(i))^2);
    end
end
%Distanz Kopie
distanz_kp=distanz;
%Bestimmung der k-Nachbarn anhand der Distanzen
%mit zwischenspeicherung der Werte in einem Vektor
samplex=rand(k,3);
sampley=rand(k,3);
distanz_nb=rand(k,3);
zw=rand(k,3);
stelle=0;
for i=1:k,
    for j=1:anzahl_dp,
        [value,stelle]=min(distanz_kp(:,j));
        %Zuweisung der Klassen anhand von Farben
        %Relevant für den Plot
        if stelle <= 51
            zw(i,j)= 1;
        elseif stelle <= 101
            zw(i,j)= 2;
        else
            zw(i,j) = 3;
        end
        samplex(i,j)=x(stelle);
        sampley(i,j)=y(stelle);
        distanz_nb(i,j)=value;
        distanz_kp(stelle,j)= 1000;
    end
    
end

%Zugehörigkeit bestimmen.
%Anhand der Mehrheitsentscheid der Nachbarn
%3x3 Vektor damit die Anzahl der Nachbarn zu jeweiligen Klasse bestimmt
%werden kann
zo=rand(3,3);
for i=1:3,
    for j=1:3,
        zo(i,j)=0;
    end
end
%Hier bestimmt man die Anzahl von Nachbarn an deren Klasse sie angehören
%Hinter für den Mehrheitsentscheid
for i=1:3,
    for j=1:k,
        if zw(j,i) == 1
            zo(i,1) = zo(i,1)+1;
        elseif zw(j,i) == 2
            zo(i,2)=zo(i,2)+1;
        else
            zo(i,3)=zo(i,3)+1;
        end 
    end
end
%Ausgaben
%Ergebnis 1 ==> Daten der Nachbarn
%Für jeden Datenpunkt einzeln
display('Zu Ergebnis 1 ==> Jeweiligen 7 Nachbarn');
Datenpunkt_1= [samplex(:,1) sampley(:,1)];
display(Datenpunkt_1);
Datenpunkt_2= [samplex(:,2) sampley(:,2)];
display(Datenpunkt_2);
Datenpunkt_3= [samplex(:,3) sampley(:,3)];
display(Datenpunkt_3);
%Distanzmatrix ausgeben Ergebnis 2
display('Zu Ergebnis 2 ==> Erste Spalte gehöhrt zu Datenpunkt 1 usw.');
distanzmatrix=[distanz_nb(:,1) distanz_nb(:,2) distanz_nb(:,2) ];
display(distanzmatrix);
%Datenpunkte ploten & Klassen zugehörgkeit
for i=1:anzahl_dp,
    %Maximum zur Bestimmung der Zugehörigkeit des Datenpunktes zu einer
    %Klasse
    [value,stelle]=max(zo(i,:));
    %Jeweilige Plot wie in der Aufgabe gewünscht
    if stelle == 1
        plot(startcentx(i),startcenty(i),'kX','MarkerSize',5,'DisplayName','Datenpunkt 1');
        plot(startcentx(i),startcenty(i),'ko','MarkerSize',5,'DisplayName','Zugehörigkeit Iris setosa');
        
    elseif stelle == 2
        plot(startcentx(i),startcenty(i),'kX','MarkerSize',5,'DisplayName','Datenpunkt 2');
        plot(startcentx(i),startcenty(i),'ro','MarkerSize',5,'DisplayName','Zugehörigkeit Iris versicolor');
    else 
        plot(startcentx(i),startcenty(i),'kX','MarkerSize',5,'DisplayName','Datenpunkt 3');
        plot(startcentx(i),startcenty(i),'go','MarkerSize',5,'DisplayName','Zugehörigkeit Iris virginica');
    end
    
end

