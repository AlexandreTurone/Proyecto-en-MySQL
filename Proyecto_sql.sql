SELECT * FROM exams.exams;
use exams;

create table Nota_nivel_educacion
as select `parental level of education`, avg(`math score`) as Nota_media_mates, avg(`reading score`) as Nota_media_lectura, avg(`writing score`) as Nota_media_escritura 
from exams.exams 
group by `parental level of education`;

select `parental level of education`, sum(Nota_media_mates + Nota_media_lectura + Nota_media_escritura)/3 as Nota_media
 from Nota_nivel_educacion 
 group by `parental level of education`;
 
 #Concluimos con que la nota media más alta es para los que tienen el bachillerato o un master. Vamos a ver si 
 #hay una correlación con haber realizado test durante el curso o no.
 
create table eval_continua
as select `test preparation course`, avg(`math score`) as Nota_media_mates, avg(`reading score`) as Nota_media_lectura, avg(`writing score`) as Nota_media_escritura
from exams.exams 
group by `test preparation course`;

#Efectivamente, podemos ver a simple vista cómo los alumnos que han realizado una evaluación contínua consiguen tener una nota media 
#mayor que los que no lo han hecho.

#Por último, vamos a consultar por géneros

create table Generos 
as select gender, avg(`math score`) as Nota_media_mates, avg(`reading score`) as Nota_media_lectura, avg(`writing score`) as Nota_media_escritura
from exams.exams 
group by gender;

#Obtenemos una nota media mayor para las mujeres que para los hombres. 
#Veamos si hay alguna correlación con los test realizados durante todo el curso.
create table hombres
as select gender, `test preparation course` from exams.exams where gender = 'male';

select `test preparation course`, count(`test preparation course`) c 
from hombres
group by `test preparation course` having c > 1;

#Hay 175 hombres que han completado la evaluación continua y 342 que no. 


create table mujeres
as select gender, `test preparation course` from exams.exams where gender = 'female';

select `test preparation course`, count(`test preparation course`) c 
from mujeres
group by `test preparation course` having c > 1;

#En el caso de las mujeres 160 han completado la evaluación continua y 323 no
#Realizando un cácluclo rápìdo, el 51,1% de los hombres han realizado la evaluacion continua y el 49.5% para las mujeres

create table generos_grado
as select gender, `parental level of education` ,  count(`parental level of education`) as suma
from exams.exams 
group by gender, `parental level of education` having suma > 1;

select sum(suma) as suma_hombres from generos_grado where gender = 'male';
select sum(suma) as suma_mujeres from generos_grado where gender = 'female';

#Concluimos este ejercicio con que la nota media de las mujeres es más alta que la de los hombres, a pesar de que estos últimos 
#hayan sido más en realizar una evaluación continua. 
