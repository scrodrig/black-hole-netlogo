breed [planets planet]
breed [star stars]

planets-own [
  mass
  velocity
  acceleration
]

to setup
  clear-all
  
  create-star 1 [
    setxy 0 0  ; Set the coordinates of the star at the center
    set color yellow  ; Set the color of the star
    set shape "circle"  ; Set the shape of the star
    set size 3  ; Set the size of the star
  ]
  
  ; Create planets avoiding the position of the star
  
  ; Create planets avoiding the position of the star
  repeat 10 [
    let x-position random-xcor
    let y-position random-xcor
    create-planets 1 [
      setxy x-position y-position  ; Set the coordinates of the planet
      set color blue
      set shape "circle"  ; Change the shape of the planet to a circle
      set mass 1 + random 9  ; Random mass between 1 and 10
      set velocity 0.1 * random 1  ; Random initial velocity
      set acceleration 0
    ]
  ]
  
  
    ; Crear planetas evitando la posición de la estrella
;  create-planets 10 [
;    let planet-position no-overlap-star  ; Obtener una posición que no se superponga con la estrella
;    setxy (item 0 planet-position) (item 1 planet-position)  ; Establecer las coordenadas del planeta
;    set color blue
;    set shape "circle"  ; Cambiar la forma del planeta a un círculo
;    set mass 1 + random 9  ; masa aleatoria entre 1 y 10
;    set velocity 0.1 * random 1  ; velocidad inicial aleatoria
;    set acceleration 0
;  ]
;  
  
  reset-ticks
end

to go
  ask planets [
    ; Calculate gravitational acceleration
    let gravitational-acceleration calculate-gravitational-acceleration xcor ycor
    
    ; Update acceleration with gravitational acceleration
    set acceleration gravitational-acceleration
    
    ; Update velocity and position
    set velocity velocity + acceleration
    forward velocity
  ]
  tick
end


to-report calculate-gravitational-acceleration [x y]
  let G 6.674e-11  ; Universal gravitational constant
  let black-hole-x 0  ; Black hole coordinates
  let black-hole-y 0
  let distance-sqr (x - black-hole-x) ^ 2 + (y - black-hole-y) ^ 2  ; Distance squared between the planet and the black hole
  let gravitational-force G * mass / distance-sqr  ; Gravitational force according to universal law of gravitation
  let angle atan (black-hole-y - y) (black-hole-x - x)  ; Angle of gravitational force
  
  ; x and y components of gravitational acceleration
  let acceleration-x gravitational-force * cos(angle) / mass
  let acceleration-y gravitational-force * sin(angle) / mass
  
  ; Return magnitude of gravitational acceleration
  report sqrt(acceleration-x ^ 2 + acceleration-y ^ 2)
end
