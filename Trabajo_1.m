% UNIVERDIDAD DE CUENCA | INGENIERIA EN TELECOMUNICACIONES
% SISTEMAS LINEALES Y SEÑALES | TRABAJO 1: CONVOLUCIÓN
% CABRERA EVELYN - MEJIA ANDRES - MOLINA JOHN
% PROCESAMIENTO DE AUDIO POR REVERBERACIÓN O ECO 
% Funciones generadas por guide
function varargout = Trabajo_1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Trabajo_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Trabajo_1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function Trabajo_1_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Trabajo_1_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
function canciones_Callback(hObject, eventdata, handles)
function canciones_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function canciones2_Callback(hObject, eventdata, handles)
function canciones2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Boton para restablecer la interfaz a los valores iniciales
function pushbutton7_Callback(hObject, eventdata, handles)
    cla(handles.axes1, 'reset');
    cla(handles.axes3, 'reset');
    cla(handles.axes4, 'reset');
    set(handles.text5, 'String', '');
    set(handles.canciones, 'Value', 1);
    set(handles.canciones2, 'Value', 1);

    % Limpiar variables globales
    clear global conv_resultante sonido1_fs player;


% Botón para empezar la convolución
function pushbutton2_Callback(hObject, eventdata, handles)
global conv_resultante sonido1_fs % Declaramos las variables globales a usar en otras funciones
contenido=get(handles.canciones,'String'); % String del menú de canciones
a=get(handles.canciones,'Value'); % Posición de la canción deseada
cancion=contenido(a);
% Listado de canciones
switch cell2mat(cancion) % Se convierte en un arreglo ordinario
    case 'Canción 1'
        audio='cancion1.wav';
    case 'Canción 2'
        audio='cancion2.wav';
    case 'Sonido 1'
        audio='sonido1.wav';
    case 'Sonido 2'
        audio='sonido2.wav';
    case 'Sonido 3'
        audio='sonido3.wav';
    case 'Sonido 4'
        audio='sonido4.wav';
end
% Sonido para la señal de entrada x[t]        
[sonido1_x, sonido1_fs] = audioread(audio);
sonido1_ft=sonido1_x(:,1);
sonido1_max=max(abs(sonido1_ft));
sonido1_ft=sonido1_ft/sonido1_max;
sonido1_length=length(sonido1_ft);
sonido1_t=(0:sonido1_length-1)/sonido1_fs;
plot(handles.axes1,sonido1_t,sonido1_ft);

% Selección de caso para Reverberación o Eco
contenido=get(handles.canciones2,'String');
a=get(handles.canciones2,'Value');
cancion2=contenido(a);
switch cell2mat(cancion2)
    case 'Reverberación'
        audio2='Golpe.wav';
    case 'Eco'
        audio2='Golpe_eco.wav';
end

% Efecto de Reverberación para la respuesta de impulso h[t]
[sonido2_x, sonido2_fs] = audioread(audio2);
sonido2_ft=sonido2_x(:,1);
sonido2_max=max(abs(sonido2_ft));
sonido2_ft=sonido2_ft/sonido2_max;
sonido2_length=length(sonido2_ft);
sonido2_t=(0:sonido2_length-1)/sonido2_fs;
plot(handles.axes3,sonido2_t,sonido2_ft);

% Convolucion: y[t]=x[t]*h[t]
conv_resultante=conv(sonido1_ft,sonido2_ft);
conv_resultante_max=max(abs(conv_resultante));
conv_resultante=conv_resultante/conv_resultante_max;
resultante_length=length(conv_resultante);
resultante_t=(0:resultante_length-1)/sonido1_fs;
plot(handles.axes4,resultante_t,conv_resultante);
set(handles.text5,'String','Fin de convolución')

%Boton para guardar el archivo de audio obtenido
function pushbutton3_Callback(hObject, eventdata, handles)
    global conv_resultante sonido1_fs player % Uso de las variables globales
    texto = {'Ingresa el nombre del archivo de audio:'};
    titulo = 'Guardar Resultado';
    numlines = 1;
    defaultanswer = {'resultado.wav'};
    nombre_archivo = inputdlg(texto, titulo, numlines, defaultanswer);

    if ~isempty(nombre_archivo)
        % Guardar el archivo de audio
        audiowrite(nombre_archivo{1}, conv_resultante, sonido1_fs);
        msgbox(['El resultado se ha guardado en ' nombre_archivo{1}], 'Guardar Resultado');
    end


function pushbutton5_Callback(hObject, eventdata, handles)
    global conv_resultante sonido1_fs player % Uso de las variables globales
    if isempty(player) || ~isplaying(player)
        % Reproducir el audio resultante
        player = audioplayer(conv_resultante, sonido1_fs);
        play(player);
    else
        % Pausar o reanudar la reproducción si ya está en curso
        if ispaused(player)
            resume(player);
        else
            pause(player);
        end
    end

%Boton para pausar audio
function pushbutton6_Callback(hObject, eventdata, handles)
    global player % Uso de las variables globales
    if ~isempty(player) && (isplaying(player) || ispaused(player))
        % Detener la reproducción si está en curso o pausada
        stop(player);
    end



    
