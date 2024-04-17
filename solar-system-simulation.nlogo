breed [planets planet]
breed [stars star]

globals [
  orbit-speed     ; Velocidad orbital de los planetas
  angular-speed   ; Velocidad angular de movimiento del planeta
]

planets-own [
  semimajor-axis  ; Eje semi-mayor de la órbita de los planetas
  initial-x       ; Posición inicial en x
  initial-y       ; Posición inicial en y
]

patches-own [
  painted?        ; Variable para indicar si el parche ha sido pintado
  paint-thickness ; Grosor de la pintura en el parche
]

to setup
  clear-all
  set orbit-speed 0 ; Velocidad orbital de los planetas
  set angular-speed 0.001 ; Velocidad angular de movimiento del planeta (ajustar según sea necesario)
  
  create-planets 1 [
    set breed stars   ; Creamos solo una tortuga para representar el sol y le establecemos la raza 'planets'
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
    set initial-x random 141 - 70  ; Limita el rango de valores entre -70 y 70
    set initial-y random 141 - 70  ; Limita el rango de valores entre -70 y 70
    set semimajor-axis sqrt (initial-x ^ 2 + initial-y ^ 2)  ; Calculamos el eje semi-mayor como la distancia al origen
    setxy initial-x initial-y
    set heading random 360
  ]
  
  reset-ticks
end

to go
  ask planets [
    let planet-angle heading
    let x semimajor-axis * cos planet-angle  ; Calcula la nueva posición x del planeta
    let y semimajor-axis * sin planet-angle  ; Calcula la nueva posición y del planeta
    
    ; Mueve el planeta a su nueva posición
    setxy ([xcor] of one-of turtles with [breed = stars] + x) ([ycor] of one-of turtles with [breed = stars] + y)  
    
    ; Pintar el parche donde se encuentra el planeta si no ha sido pintado
    let current-patch patch-here
    if painted? = 0 [
      ask current-patch [
        set pcolor [color] of myself  ; Pinta el parche con el color del planeta
        set painted? 1  ; Marca el parche como pintado
        set pcolor 0.2
      ]
    ] 
    
    ; Ajustar el ángulo de la tortuga para simular un movimiento más lento
    set heading (heading + angular-speed) mod 360
  ]
  tick
end
