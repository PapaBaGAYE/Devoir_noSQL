# NEO4J
# 1.
   MATCH (p:Person)-[:ACTED_IN]->(m:Movie {title : "The Matrix"})
    RETURN p.name

    MATCH (p:Person {name : "Tom Hanks"})-[r]->(m:Movie)
    RETURN m.title as titre, type(r) as relation 

# 2.
    MATCH (p:Person {name : "Tom Hanks"})-[r:ACTED_IN]->(m:Movie {title : "Apollo 13"})
    RETURN r.roles as Role

# 3.
    MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
    where exists{
        (p2:Person {name : "Tom Hanks"})-[:ACTED_IN]->(m:Movie)
        where p.name <> "Tom Hanks"
    }
    return p.name as Nom, m.title as Titre

# 4.
    MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)
    where exists{
        (p2:Person {name : "Tom Hanks"})-[:ACTED_IN]->(m:Movie)
        where exists{
            (p3:Person {name : "Madonna"})-[:ACTED_IN]->(m:Movie)
            where p.name <> "Tom Hanks" and p.name <> "Madonna"
        }
    }
    return p.name

# 5.
    MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
    WITH p, count(m) as nb_films
    RETURN p.name as Nom, nb_films

# MONGODB
# 1.
db.countries.aggregate([  
    { $match : {"region" : "Africa"}},
    { $group: {"_id" : "$name", "population_totale_par_region" : {"$sum" : "$population"}}},
    { $sort : {"population_totale_par_region" : -1}}
])

# 2.
db.countries.aggregate([
    { $match : {"region" : "Europe"}},
    { $group: { "_id" : null, "population_totale" : {"$sum" : "$population"}}}
])

# 3.
db.countries.aggregate([
    { $match : {"region" : "Africa", "languages.name" : "English"}},
    { $group: { "_id" : null, "population_totale" : {"$sum" : "$population"}}}
])

# 4.
db.countries.aggregate([
    { $match : {"languages.name" : "English"}},
    { $group: { "_id" : null, "population_totale" : {"$sum" : 1}}}
])

# 5.
    db.countries.find({"name" : "Botswana"}, {"area" : 1})
    
