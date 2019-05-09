#1 query
#SELECT COUNT(*) AS SUM FROM pages

/*#2 query 
#Написать запрос, показывающий список категорий новостей и количество новостей в
#каждой категории.
SELECT nc_name,COUNT(n_id) FROM news_categories 
LEFT JOIN news on news.n_category = news_categories.nc_id 
GROUP BY nc_name
*/

/*3.Написать запрос, показывающие список категорий обзоров и 
количество обзоров в каждой категории
SELECT rc_name,COUNT(r_id) FROM reviews_categories
LEFT JOIN reviews ON reviews.r_category = reviews_categories.rc_id
GROUP BY rc_name
*/

/*4.Написать запрос, показывающий список категорий новостей, категорий обзоров и
дату самой свежей публикации в каждой категории.
SELECT rc_name as category_name,MAX(r_dt) as last_date FROM reviews_categories
JOIN reviews ON r_category = rc_id
GROUP BY rc_name
UNION
SELECT nc_name,MAX(n_dt) FROM news_categories 
JOIN news ON n_category = nc_id
GROUP BY nc_name
*/

/*5.Написать запрос, показывающий список страниц сайта верхнего уровня (у таких
страниц нет родительской страницы) и список баннеров для каждой такой страницы.
SELECT p_name, m2m_banners_pages.b_id, b_url FROM pages
INNER JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
INNER JOIN banners ON banners.b_id = m2m_banners_pages.b_id
WHERE p_parent IS NULL
*/

/*6.Написать запрос, показывающий список страниц сайта, на которых есть баннеры.
SELECT pages.p_name FROM pages
JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
WHERE m2m_banners_pages.p_id = pages.p_id
GROUP BY pages.p_name 
*/

/*7. Написать запрос , показывающий список страниц сайта , на которых нет баннеров
SELECT pages.p_name FROM pages
LEFT JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
WHERE m2m_banners_pages.p_id IS NULL 
*/

/*8.Написать запрос , показывающий список баннеров , размещенных хотя бы 
на одной странице сайта 
SELECT DISTINCT(banners.b_id), banners.b_url FROM banners
LEFT JOIN m2m_banners_pages ON m2m_banners_pages.b_id = banners.b_id
WHERE m2m_banners_pages.b_id IS NOT NULL 
*/

/*9.Написать запрос, показывающий список баннеров, не размещённых ни на одной
странице сайта.
SELECT DISTINCT(banners.b_id), banners.b_url FROM banners
LEFT JOIN  m2m_banners_pages ON m2m_banners_pages.b_id = banners.b_id
WHERE m2m_banners_pages.b_id IS NULL
*/

/*10.Написать запрос, показывающий баннеры, для которых отношение кликов к показам
>= 80% (при условии, что баннер был показан хотя бы один раз).
SELECT DISTINCT(banners.b_id), banners.b_url , (b_click/b_show) * 100 AS rate FROM banners
WHERE ((b_click/b_show) * 100) >= 80 AND b_show IS NOT NULL
*/

/*11.Написать запрос, показывающий список страниц сайта, на которых показаны
баннеры с текстом (в поле `b_text` не NULL).
SELECT DISTINCT(p_name) FROM pages 
INNER JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
INNER JOIN banners ON banners.b_id = m2m_banners_pages.b_id
WHERE banners.b_text IS NOT NULL
*/

/*12.Написать запрос, показывающий список страниц сайта, на которых показаны
баннеры с картинкой (в поле `b_pic` не NULL).
SELECT DISTINCT(p_name) FROM pages
INNER JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
INNER JOIN banners ON banners.b_id = m2m_banners_pages.b_id
WHERE banners.b_pic IS NOT NULL 
*/

/*13.Написать запрос, показывающий список публикаций (новостей и обзоров) за 2011-й
год.
SELECT news.n_header AS header, news.n_dt AS date FROM news
WHERE n_dt >= '2011-00-00' AND n_dt <= '2012-00-00'
UNION
SELECT reviews.r_header, reviews.r_dt FROM reviews
WHERE r_dt >= '2011-00-00' AND r_dt <= '2012-00-00'
*/

/*14.Написать запрос, показывающий список категорий публикаций (новостей и обзоров),
в которых нет публикаций.
SELECT nc_name FROM news_categories
LEFT JOIN news ON news.n_category = news_categories.nc_id
WHERE news.n_category IS NULL
UNION 
SELECT rc_name FROM reviews_categories
LEFT JOIN reviews ON reviews.r_category = reviews_categories.rc_id
WHERE reviews.r_category IS NULL
*/

/*15.Написать запрос, показывающий список новостей из категории -Логистика- за 2012-й год
SELECT n_header, n_dt FROM news 
JOIN news_categories ON news_categories.nc_id = news.n_category
WHERE news_categories.nc_name = 'Логистика' AND n_dt >= '2012-00-00' AND n_dt < '2013-00-00'
*/

/*16.Написать запрос, показывающий список годов, за которые есть новости, а также
количество новостей за каждый из годов.
SELECT year(n_dt) AS year, COUNT(*) FROM news
GROUP BY year(news.n_dt) 
ORDER BY year(news.n_dt) 
*/

/*17.Написать запрос, показывающий URL и id таких баннеров, где для одного и того же
URL есть несколько баннеров.
SELECT banners.b_url, banners.b_id FROM banners
INNER JOIN ( SELECT b_url FROM banners
				GROUP BY b_url
                HAVING COUNT(b_url) > 1) j ON j.b_url = banners.b_url
 */
 /*18.Написать запрос, показывающий список непосредственных подстраниц страницы
«Юридическим лицам» со списком баннеров этих подстраниц.
SELECT p_name, banners.b_id, b_url FROM pages
INNER JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
INNER JOIN banners ON banners.b_id = m2m_banners_pages.b_id
WHERE p_parent = 1
*/

/*19.Написать запрос, показывающий список всех баннеров с картинками (поле `b_pic` не
NULL), отсортированный по убыванию отношения кликов по баннеру к показам
баннера.
SELECT b_id, b_url, b_click/b_show as rate FROM banners
WHERE b_pic IS NOT NULL
ORDER BY b_click/b_show DESC
*/

/*20.Написать запрос, показывающий самую старую публикацию на сайте (не важно –
новость это или обзор).
SELECT header, date FROM(
SELECT r_header as header , r_dt as date FROM reviews AS T
UNION 
SELECT n_header, n_dt FROM news) AS T
WHERE date = (SELECT MIN(date) FROM (
SELECT r_header as header , r_dt as date FROM reviews AS T
UNION 
SELECT n_header, n_dt FROM news) AS T )
*/

/*21.Написать запрос, показывающий список баннеров, URL которых встречается в
таблице один раз.
SELECT b_url, b_id FROM banners 
GROUP BY b_url
HAVING COUNT(b_url) = 1
*/

/*22.Написать запрос, показывающий список страниц сайта в порядке убывания
количества баннеров, расположенных на странице. Для случаев, когда на
нескольких страницах расположено одинаковое количество баннеров, этот список
страниц должен быть отсортирован по возрастанию имён страниц.
SELECT p_name, COUNT(b_id) FROM pages
JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
GROUP BY p_name
ORDER BY COUNT(b_id) DESC, p_name
*/

/*23.Написать запрос показывающий самую свежую новость и самый свежий обзор 
SELECT n_header AS header, n_dt as date FROM news
WHERE n_dt = (SELECT MAX(n_dt) FROM news)
UNION
SELECT r_header, r_dt FROM reviews
WHERE r_dt = (SELECT MAX(r_dt) FROM reviews) 
*/

/*24.Написать запрос, показывающий баннеры, в тексте которых встречается часть URL,
на который ссылается баннер.
SELECT b_id, b_url, b_text FROM banners
WHERE INSTR(b_url, b_text) AND LENGTH(b_text) > 0
*/

/*25.Написать запрос, показывающий страницу, на которой размещён баннер с самым
высоким отношением кликов к показам. 
SELECT p_name FROM pages 
INNER JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id
INNER JOIN banners ON banners.b_id = m2m_banners_pages.b_id
WHERE b_click/b_show = (SELECT MAX(b_click/b_show) FROM banners)
*/

/*26.Написать запрос, считающий среднее отношение кликов к показам по всем
баннерам, которые были показаны хотя бы один раз.
SELECT AVG(b_click/b_show) FROM banners 
WHERE b_show >= 1
*/

/*27.Написать запрос, считающий среднее отношение кликов к показам по баннерам, у
которых нет графической части (поле `b_pic` равно NULL).
SELECT AVG(b_click/b_show) FROM banners 
WHERE b_pic IS NULL
*/

/*28.Написать запрос, показывающий количество баннеров, размещённых на страницах
сайта верхнего уровня (у таких страниц нет родительских страниц).
SELECT COUNT(banners.b_id) AS COUNT FROM banners 
INNER JOIN m2m_banners_pages ON m2m_banners_pages.b_id = banners.b_id
INNER JOIN pages ON pages.p_id = m2m_banners_pages.p_id
WHERE p_parent IS NULL
*/

/*29.Написать запрос, показывающий баннер(ы), который(ые) показаны на самом
большом количестве страниц.
SELECT * FROM (SELECT T.b_id, b_url, COUNT(m2m_banners_pages.b_id) AS COUNT FROM banners AS T
				JOIN m2m_banners_pages ON m2m_banners_pages.b_id = T.b_id
				GROUP BY T.b_id) AS T
WHERE COUNT = (SELECT MAX(COUNT) FROM (SELECT T.b_id, b_url, COUNT(m2m_banners_pages.b_id) AS COUNT FROM banners AS T
										JOIN m2m_banners_pages ON m2m_banners_pages.b_id = T.b_id
										GROUP BY T.b_id) AS T ) 
*/

/*30.Написать запрос, показывающий страницу(ы), на которой(ых) показано больше всего
баннеров.
SELECT * FROM (SELECT p_name, COUNT(m2m_banners_pages.p_id) AS COUNT FROM pages AS T
				JOIN m2m_banners_pages ON m2m_banners_pages.p_id = T.p_id
				GROUP BY T.p_id) AS T
WHERE COUNT = (SELECT MAX(COUNT) FROM (SELECT p_name, COUNT(m2m_banners_pages.p_id) AS COUNT FROM pages AS T
				JOIN m2m_banners_pages ON m2m_banners_pages.p_id = T.p_id
				GROUP BY T.p_id) AS T)
*/