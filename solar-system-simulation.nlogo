breed [planets planet]
breed [stars star]

globals [
  eccentricity    ; Excentricidad de las órbitas
  orbit-speed     ; Velocidad orbital de los planetas
]

planets-own [
  semimajor-axis  ; Eje semi-mayor de la órbita de los planetas
  initial-x       ; Posición inicial en x
  initial-y       ; Posición inicial en y
]

to setup
  clear-all
  set eccentricity 0.2   ; Excentricidad de las órbitas
  set orbit-speed 1 ; Velocidad orbital de los planetas
  
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
    set initial-x random 141 - 70  ; Limita el rango de valores entre -60 y 60
    set initial-y random 141 - 70  ; Limita el rango de valores entre -60 y 60
    set semimajor-axis sqrt (initial-x ^ 2 + initial-y ^ 2)  ; Calculamos el eje semi-mayor como la distancia al origen
    setxy initial-x initial-y
    set heading random 360
  ]
  
  reset-ticks
end


to go
  ask planets [
    if breed = planets [
      let current-angle orbit-speed * ticks  ; Calcula el ángulo actual en función del tiempo transcurrido
      let x semimajor-axis * cos current-angle  ; calcula la nueva posición x
      let y semimajor-axis * sin current-angle  ; calcula la nueva posición y
      let orbit-speed-with-variation orbit-speed + (random-float 0.1 - 0.05)  ; Agrega una pequeña variación aleatoria a la velocidad orbital
      let planet-speed orbit-speed-with-variation * ticks  ; Calcula la velocidad orbital del planeta
      let planet-angle current-angle + random-float 360  ; Introduce una variación aleatoria en el ángulo inicial del planeta
      let planet-x semimajor-axis * cos planet-angle  ; Calcula la nueva posición x del planeta
      let planet-y semimajor-axis * sin planet-angle  ; Calcula la nueva posición y del planeta
      setxy ([xcor] of one-of turtles with [breed = stars] + planet-x) ([ycor] of one-of turtles with [breed = stars] + planet-y)  ; actualiza la posición del planeta
    ]
  ]
  tick
end



