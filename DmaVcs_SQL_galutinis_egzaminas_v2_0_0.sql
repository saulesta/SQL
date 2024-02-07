######################################################################
###
###		Studentas
###			vardas: Saule
###			pavarde: Staneviciute
###
#######################################################################
### 		Viso galima surinkti 19 taškų. 19 t = 10 balų. 			###
#######################################################################

/* 
*	UŽDUOTIS 01: 
*	(1 taškas)
*	Pateikite tik tuos mokėjimus, kurių vertė (amount) yra didesnė nei 2. 
*   Naudokite lentelę payment.
*/
	select *
    from sakila.payment
    where amount > 2;
	
    
/* 
*	UŽDUOTIS 02: 
*	(1 taškas)
*	Pateikite filmus, kurių reitingas (rating) yra „PG“,
*	o pakeitimo kaina (replacement_cost) yra mažesnė nei 10. 
*    Naudokite lentelę film.
*/
	select *
    from sakila.film
    where rating like 'PG' AND replacement_cost < 10;
    
    
/* 
*	UŽDUOTIS 03: 
*	(1 taškas)
*	Suskaičiuokite vidutinę nuomos kainą (rental_rate) kiekvieno
*	reitingo filmams, atsakymą pateikite tik su 2 skaičiais po kablelio. 
*   Ne apvalinti! Tiesiog „nupjauti“ atsakymą ties dviem skaičiais po kablelio. 
*	Naudokite lentelę film.
*/
	select rating as 'reitingas', truncate(avg(rental_rate), 2) as 'vidutine nuomos kaina'
    from sakila.film
    group by rating;
    
    
/* 
*	UŽDUOTIS 04: 
*	(1 taškas)
*	Išspausdinkite visų klientų vardus (first_name), o šalia vardų stulpelio
*	suskaičiuokite kiekvieno vardo ilgį (kiek varde yra raidžių). 
*	Naudokite lentelę customer
*/
	select first_name as 'kliento vardas', length(first_name) as 'vardo ilgis'
    from sakila.customer;
    
    
/* 
*	UŽDUOTIS 05: 
*	(1 taškas)
*	Ištirkite kelinta raidė yra „e“ kiekvieno filmo aprašyme (description).
*	Naudokite lentelę film.
*/    
    select description as 'aprasymas', locate('e',description) as 'kelinta raidė yra „e“'
    from sakila.film;
    
    
/* 
*	UŽDUOTIS 06: 
*	(2 taškai)
*	Susumuokite kiekvieno reitingo (rating) bendrą filmų trukmę (length).
*	Išspausdinkite tik tuos reitingus, kurių bendra filmų trukmė yra
*	ilgesnė nei 22000.
*	Naudokite lentelę film.
*/   
	select rating as 'reitingas', sum(length) as 'bendra filmu trukme'
    from sakila.film
    group by rating
    having sum(length) > 22000;

    
    
    
/* 
*	UŽDUOTIS 07: 
*	(2 taškai)
*	Išspausdinkite visų filmų aprašymus (description), 
*   šalia išspausdinkite aprašymus sudarančių elementų skaičių (simboliu skaicius). Trečiame stulpelyje išspausdinkite
*	aprašymų elementų skaičių, juose visas raides „a“ pakeisdami į „OO“.
*	Tai reiškia turite aprašyme visas raides „a“ pakeisti į „OO“ ir tada
*	suskaičiuoti naujo objekto elementų skaičių. 
*	Naudokite lentelę film_text.
*/ 
	
    select description as 'aprasymas', length(description) as 'elementu skaicius' , replace(description, 'a' , 'OO') as 'visos raides „a“ pakeistos į „OO“' , LENGTH(replace(description, 'a' , 'OO')) as 'naujo objekto elementų skaičius'
    from sakila.film_text;
    
/* 
*	UŽDUOTIS 08: 
*	(3 taškai)
*	Parašykite SQL užklausą, kuri suskirstytų filmus pagal jų reitingus (rating)
*	į tokias kategorijas:
*		Jei reitingas yra „PG“ arba „G“ tada „PG_G“
*		Jei reitingas yra „NC-17“ arba „PG-13“ tada „NC-17-PG-13“
*		Visus kitus reitingus priskirkite kategorijai „Nesvarbu“
*	Kategorijas atvaizduokite stulpelyje „Reitingo_grupe“
*	Naudokite lentelę film.
*/ 
	select rating as 'reitingas',
    CASE
    WHEN rating in ('PG','G') then 'PG_G'
    WHEN rating in ('NC-17', 'PG-13') then 'NC-17-PG-13'
    ELSE 'Nesvarbu'
    END AS reitingo_grupe
    from sakila.film
    group by rating;
    

    
    
/* 
*	UŽDUOTIS 09: 
*	(3 taškai)
*	Susumuokite nuomavimosi trukmę (rental_duration), kiekvienanai filmo
*	kategorijai (name). 
*	Išspausdinkite tik tas kategorijos, kurių rental_duration suma yra 
*	didesnė nei 300. 
*	Užduotį atlikite apjungiant lenteles. 
*	Naudokite lenteles film, film_category, category.
*/ 
	
    select sum(rental_duration) as 'nuomavimosi trukme', c.name as 'filmo kategorija'
    from sakila.film f
    join sakila.film_category fc on f.film_id = fc.film_id
    join sakila.category c on fc.category_id = c.category_id
    group by c.name
    having sum(rental_duration) > 300;
    
    
    
/* 
*	UŽDUOTIS 10: 
*	(4 taškai su subquery, be subguery 2 taškai)
*	Pateikite klientų vardus (first_name) ir pavardes (last_name), kurie 
*	išsinuomavo filmą „AGENT TRUMAN“. Užduotį atlikite naudodami subquery.
*	Užduotis atlikta teisingai be subquery vertinama 2t. 
*	Naudokite lenteles customer, rental, inventory, film.
*/ 
	
select first_name 'kliento vardas', last_name as 'kliento pavarde'
from sakila.customer
where customer_id in (select customer_id from sakila.rental where inventory_id in (select inventory_id from sakila.inventory where film_id = 6));


  
    
    