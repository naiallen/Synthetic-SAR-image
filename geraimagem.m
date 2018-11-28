%% Tamanho da imagem
sizeazi = handles.par.N_azimuth; % x axis
sizerange = handles.par.N_range; % y axis

handles.imraw = zeros([sizeazi sizerange]);

nClasses = sum(handles.RCS);
cl = [];
classeindex = [];
if handles.RCS(1) == 1
    cl = [cl 50];
    classeindex = [classeindex 1];
end
if handles.RCS(2) == 1
    cl = [cl 20];
    classeindex = [classeindex 2];
end
if handles.RCS(3) == 1
    cl = [cl 1];
    classeindex = [classeindex 3];
end
if handles.RCS(4) == 1
    cl = [cl -50];
    classeindex = [classeindex 4];
end
    
stdev = 5;
%Divide the image into rectangular spaces
nRect = (randi(5,1,1)+1)^2;
nSide = sqrt(nRect);

mt = [round(1:sizeazi/nSide:sizeazi) sizeazi];
nt = [round(1:sizerange/nSide:sizerange) sizerange];
 
cindex = [];
cposition = [];
handles.classes = [];

if (nClasses > 0)
    if (nClasses == 1)
        handles.imraw(1:end, 1:end) = cl(1);
    else
        for ii=1:nSide
            for jj=1:nSide
                sx = mt(ii+1) - mt(ii);
                sy = nt(jj+1) - nt(jj);
                
                
                index = randi(nClasses,1,1);
                cindex = [cindex; classeindex(index)];
                position = [mt(ii) mt(ii+1)-1 nt(jj) nt(jj+1)-1];
                cposition = [cposition; position];
                
                handles.imraw(mt(ii):mt(ii+1)-1, nt(jj):nt(jj+1)-1) = (stdev*randn(sx, sy) + cl(index));
            end
        end
    end
end



handles.classes.index = cindex;
handles.classes.position = cposition;



