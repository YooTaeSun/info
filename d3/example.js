function main(){
    // d3.select("p").style("color", "green");
    // d3.select("#p2").style("color", "red");
    // d3.selectAll("p").style("color", "red");
    d3.select("table").selectAll("td").style("color", "red");
    d3.select("p").text("test")

    // d3.select("body")
    // .append("p")
    // .text("Yay!");

    let ddd = d3.select("div")
    .insert("p")
    .text("nnnnn")

    // d3.select("p").remove()
    d3.select("p").html("<em>This is a new inner html</em>")
    // d3.select("#p3").attr("class", "error");

    d3.selectAll("input").property("checked", true)
    d3.selectAll("#p10").classed("error", true); 

    let datAttr = [6,5,4,3,2,1,0];
    d3.select("#d1")
    .selectAll("p")
    // .append("p")
    .data(datAttr)
    .enter()
    .append("p")
    .text(function(d, i){
        console.log("d: " + d + ", i: " + i);
        // console.log("i: " + i);
        return d;
    })
}