breed [planets planet]
breed [stars star]

globals [
  semimajor-axis  ; Eje semi-mayor de la órbita de los planetas
  eccentricity    ; Excentricidad de las órbitas
  orbit-speed     ; Velocidad orbital de los planetas
]

to setup
  clear-all
  set semimajor-axis 50  ; Ajusta la escala según tus necesidades
  set eccentricity 0.2   ; Excentricidad de las órbitas
  set orbit-speed 1      ; Velocidad orbital de los planetas
  
  create-planets 1 [
    set breed stars   ; Creamos solo una turtle para representar el sol y le establecemos la raza 'planets'
    set shape "circle"
    set color yellow
    set size 3
    setxy 0 0  ; Coloca el sol en el centro
  ]
  
  create-planets 9 [
    set breed planets
    set shape "circle"
    set color one-of [blue green red orange brown yellow cyan magenta]  ; Colores para los planetas
    set size 1
    setxy random-xcor random-ycor
    set heading random 360
  ]
  
  reset-ticks
end

to go
  ask planets [
    if breed = planets [
      let distance-to-sun distance one-of planets with [self != myself] ; asegurarse de que no esté apuntando a sí mismo
      let angle-to-sun towards one-of other planets with [self != myself]
      let x semimajor-axis * cos angle-to-sun
      let y (semimajor-axis * sqrt (1 - eccentricity ^ 2)) * sin angle-to-sun
      setxy x y
      set heading angle-to-sun
      forward orbit-speed
    ]
  ]
  tick
end

