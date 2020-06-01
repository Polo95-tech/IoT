% Marco Döhring

%Einlesen der Testdaten mit relevanten Merkmalen
clear all;
clear all;
close all;
%close all
load fisheriris
X = meas(:,3:4);
%Erzeugen des Diagramm mit Testdaten
figure;
%plot(X(:,1),X(:,2),'ko','Markersize',2,'MarkerEdgeColor','black');

title 'Iris Daten'
xlabel 'Länge Blütenblatt in cm';
ylabel 'Breite Blütenblatt in cm';
%mit hold on weitere plot Befehle zu dem aktuellen Diagramm einfügen
hold on;
%Wahl der Iterationen für den Algorithmus
k=3;
%Variblen für die neue Centriaden
c1x=0;
c1y=0;
c2x=0;
c2y=0;
c3x=0;
c3y=0;
%Anzahl als Teiler zu neu Bestimmung
anzahlc1=0;
anzahlc2=0;
anzahlc3=0;
%Input werte in x-& y-Koordinaten aufteilen
x=(X(:,1));
y=(X(:,2));
%Zufälligen Start Centroiden erzeugen aus Maximum & Minimum 
%Bestimmung der Minima & Maxima der jeweiligen Koordinaten
value_x_max = max(x(:));
value_y_max = max(y(:));
value_x_min = min(x(:));
value_y_min = min(y(:));
%Die drei Start Centroiden  bestimmen durch zufällige Werte
%Entsprechend aus den Minima & Maxima der x/y-Koordinaten
%Wird ein jeweils für die x-Koordinate & y-Koordinate ein Vektor der Größe
%1x3 aus zufälligen Werten erzeugt
startcentx=rand(3,1)*range([value_x_min value_x_max])+min([value_x_min value_x_max]);
startcenty=rand(3,1)*range([value_y_min value_y_max])+min([value_y_min value_y_max]);
%Werte einmal anzeigen lassen
display("Start Centroiden rot: ("+startcentx(1,1)+";"+startcenty(1,1)+")");
display("Start Centroiden green: ("+startcentx(2,1)+";"+startcenty(2,1)+")");
display("Start Centroiden magenta: ("+startcentx(3,1)+";"+startcenty(3,1)+")");
%Bedinung
abbruch=true;
while abbruch == true
    %Bestimmen der Distanzen durch vorgabe des Algorithmus
    distanz=rand(150,3);
    for i=1:k,
        for j=1:150,
            distanz(j,i)=((x(j)-startcentx(i))^2)+((y(j)-startcenty(i))^2);
        end
    end
    samplex=rand(150,3);
    sampley=rand(150,3);
    %Init mit Null
    for i=1:3,
        for j=1:150,
            samplex(j,i)=0.0;
            sampley(j,i)=0.0;
        end
    end
    anzahlc1=0;
    anzahlc2=0;
    anzahlc3=0;
    %Zuordnung zu den Centroiden mit Summierung der Werte & Mitzählen der
    %Anzahl an Werten
    for i=1:150,
            [value,stelle]=min(distanz(i,:));
            if stelle == 1
                c1x = c1x + x(i);
                c1y = c1y + y(i);
                anzahlc1 = anzahlc1 + 1;
                samplex(anzahlc1,stelle) = x(i);
                sampley(anzahlc1,stelle) = y(i);
            elseif stelle == 2
                c2x = c2x + x(i);
                c2y = c2y + y(i);
                anzahlc2 = anzahlc2 + 1;
                samplex(anzahlc2,stelle) = x(i);
                sampley(anzahlc2,stelle) = y(i);
            else 
                c3x = c3x + x(i);
                c3y = c3y + y(i);
                anzahlc3 = anzahlc3 + 1;
                samplex(anzahlc3,stelle) = x(i);
                sampley(anzahlc3,stelle) = y(i);
            end
    end
    %Bestimmung der neuen Centroiden + Abbruch Kriterium falls einer keiner
    %Distanz mehr hinzugefügt werden kann.
    if anzahlc1 == 0
        abbruch = false;
    elseif anzahlc2 == 0
        abbruch = false;
    elseif anzahlc3 == 0
        abbruch = false;
    else
        startcentx(1)= (c1x/anzahlc1); 
        startcenty(1)=(c1y/anzahlc1);
        startcentx(2)= (c2x/anzahlc2); 
        startcenty(2)=(c2y/anzahlc2);
        startcentx(3)= (c3x/anzahlc3); 
        startcenty(3)=(c3y/anzahlc3);
    end
end

%Ausgaben
%Distanzmatrix
display("Distanzmatrix: ");
display(distanz);
%Ausgabe des letzten finalen Centroiden mit zu geordneten Samples
display("Finaler Centroid 1 (Rot): ["+startcentx(1)+","+startcenty(1)+"] mit Samples: ");
for i=1:anzahlc1,
    display("["+samplex(i,1)+","+sampley(i,1)+"]");
end
display("Finaler Centroid 2 (Grün): ["+startcentx(2)+","+startcenty(2)+"] mit Samples: ");
for i=1:anzahlc2,
    display("["+samplex(i,2)+","+sampley(i,2)+"]");
end
display("Finaler Centroid 3 (Magenta: ["+startcentx(3)+","+startcenty(3)+"] mit Samples: ");
for i=1:anzahlc3,
    display("["+samplex(i,3)+","+sampley(i,3)+"]");
end

%Zugehöroges Diagramm
%Objekte darstellen
plot(X(:,1),X(:,2),'ko','Markersize',2,'MarkerEdgeColor','black');
hold on;
%Finalen Marker
for i=1:k,
        if i == 1
            T = [1 0 0];
        elseif i == 2
            T = [0 1 0];
        else
            T = [1 0 1];
        end
        plot(startcentx(i,1),startcenty(i,1),'Marker','*','Markersize',5,'MarkerEdgeColor',T);
        hold on;
end
%Samples
for i=1:anzahlc1,
    plot(samplex(i,1),sampley(i,1),'Marker','o','Markersize',5,'MarkerEdgeColor',[1 0 0]);
end
for i=1:anzahlc2,
     plot(samplex(i,2),sampley(i,2),'Marker','o','Markersize',5,'MarkerEdgeColor',[0 1 0]);
end
for i=1:anzahlc3,
     plot(samplex(i,3),sampley(i,3),'Marker','o','Markersize',5,'MarkerEdgeColor',[1 0 1]);
end

