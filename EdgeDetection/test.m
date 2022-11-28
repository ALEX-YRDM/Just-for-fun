%% 初始化
clc;clear;

%% 获取原视频帧数据
path='kunkun.mp4';    %原视频存放路径,相对路径和绝对路径均可
obji=VideoReader(path);
num=obji.NumFrames; %获取视频帧数
disp(['总图片帧数为：',num2str(num)])

%% 创建视频对象并打开
Wobj=VideoWriter('test.mp4', 'MPEG-4');   % 确定输出视频的文件名为test.mp4
%输出视频，mp4格式合成的视频较小，如果想更高清可以改为avi格式，只需将'MPEG-4'改为'Uncompressed AVI'
open(Wobj);

%% 对每一帧进行边缘检测并保存到视频对象中
for i=1:num
  frame=read(obji,i);
  f=rgb2gray(frame);
  roberts=edge(f,'Sobel');  %选择算子边缘检测,直接调用库函数edge
  %'roberts','Sobel'、'Prewitt'、'LOG'或'Canny'，尝试不同的算子
  Img = mat2gray(1-roberts);
  imshow(Img)
  writeVideo(Wobj,Img);  
  if (rem(i,100) == 0)
    disp(['****************',num2str(i),'****************'])
  end
end 

%% 关闭视频对象，并提示完成
close(Wobj);
disp('已完成')