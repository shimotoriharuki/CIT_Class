[verts, faces, cindex] = teapotGeometry;
figure
p = patch('Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp');
view(400,-52)     % change the orientation
axis equal off    % make the axes equal and invisible

p.FaceAlpha = 0;   % make the object semi-transparent
p.FaceColor = 'none';    % turn off the colors

p.FaceAlpha = 1;           % remove the transparency
p.FaceColor = 'interp';    % set the face colors to be interpolated
p.LineStyle = 'none';      % remove the lines
colormap(summer)           % change the colormap

l = light('Position',[-500 500 500],'Style','infinite');
lighting gouraud
material shiny

% l.Position = [1000 10 -10];