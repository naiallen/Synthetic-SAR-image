function y = rect_function(t, t0, T)  		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE
%    Gerar um pulso retangular
%
% INPUT
%    t                  Vetor de Tempo
%
%    t0                 Time shift
%                       
%    T                  Tamanho do pulso 
%                       
%
% OUTPUT
%    y                  Pulso retangular 
%                      
%
% REVISION
%    Version |   Date     |   Author          | 
%    V1.0    |            |                   |  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


y       = zeros(length(t),1);
aux     = find(abs(t-t0)<=T/2);
y(aux)  = 1;


