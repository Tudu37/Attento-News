import 'package:attento_news/data/models/news_model.dart';
import 'package:attento_news/logic/provider_state.dart';
import 'package:attento_news/presentation/new_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AttentoNewsHomePage extends StatefulWidget {
  const AttentoNewsHomePage({Key? key}) : super(key: key);

  @override
  State<AttentoNewsHomePage> createState() => _AttentoNewsHomePageState();
}

class _AttentoNewsHomePageState extends State<AttentoNewsHomePage> with TickerProviderStateMixin {


  TextEditingController searchController = TextEditingController();
  late TabController tabController ;

  ScrollController sController = ScrollController();
  bool isLoadingMore = false;
  int apiPage = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    sController.addListener(control);
    tabController.addListener(tControl);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.greenAccent.shade200,
      body: Consumer<ProviderState>(
            builder: (context,provider,child) {
              if (provider.headlineNews == null && provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (provider.headlineNews == null) {
                // Handle null case when not loading
                return Center(child: Text('No headlines available'));
              }

              return CustomScrollView(
              slivers: [
              SliverPersistentHeader(
                // pinned: true,
                floating: true,
                  delegate: CustomSliverAppBar(height: 250.0,tcontroller: tabController,headlineNews:provider.headlineNews! )
              ),

              SliverAppBar(
                pinned: true,
                toolbarHeight: 55,
                leading: IconButton(onPressed: (){},icon: Icon(Icons.menu_outlined),),
                title: Text("Audento News"),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.greenAccent,Colors.blue]),
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                actions: [
                  Icon(Icons.notifications),
                  Padding(padding:const EdgeInsets.symmetric(horizontal: 3),child: Icon(Icons.search)),
                  Padding(padding:const EdgeInsets.only(right: 3) ,child: Icon(Icons.location_pin)),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(25),
                  child: TabBar(
                    controller: tabController,
                    isScrollable:true,
                    tabs: [
                      Tab(text: "Headline"),
                      Tab(text: "Health",),
                      Tab(text: "Science"),
                      Tab(text: "Sports"),
                      Tab(text: "Technology"),
                    ],
                  ),
                ),
              ),

                SliverFillRemaining(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    HeadlineWIdget(provider.headlineNews!),
                    HealthWIdget(provider.healthNews!),
                    ScienceWIdget(provider.scienceNews!),
                    SportsWIdget(provider.sportsNews!),
                    TechnologyWIdget(provider.tecnologyNews!),
                    // Container(color: Colors.blue,),
                    // Container(color: Colors.green,),
                    // Container(color: Colors.yellow,),
                    // Container(color: Colors.red,),
                  ],
                ),
              ),


        ],
      );
            }
          ),
    );
  }

  void control(){
    final provider = Provider.of<ProviderState>(context,listen: false);
    if(isLoadingMore){return;}

    if(provider.tpage==0){
      if(sController.position.pixels==sController.position.maxScrollExtent && provider.he_apiPage<=provider.headlineNews!.totalResults!%10){
        print("==================max================");
        setState(() {
          isLoadingMore=true;
          // apiPage++;
          provider.updateCustomApiPage(0);
        });
          provider.getHeadlineNews();

        setState(() {
          isLoadingMore=false;
        });

      }
    }else if(provider.tpage==1){
      if(sController.position.pixels==sController.position.maxScrollExtent && provider.hl_apiPage<=provider.headlineNews!.totalResults!%10){
        print("==================max================");
        setState(() {
          isLoadingMore=true;
          // apiPage++;
          provider.updateCustomApiPage(1);
        });
          provider.getHealthNews();

        setState(() {
          isLoadingMore=false;
        });
      }
  }else if(provider.tpage==2){
      if(sController.position.pixels==sController.position.maxScrollExtent && provider.sc_apiPage<=provider.headlineNews!.totalResults!%10){
        print("==================max================");
        setState(() {
          isLoadingMore=true;
          // apiPage++;
          provider.updateCustomApiPage(2);
        });
          provider.getScienceNews();

        setState(() {
          isLoadingMore=false;
        });

      }
    }else if(provider.tpage==3){
      if(sController.position.pixels==sController.position.maxScrollExtent && provider.sp_apiPage<=provider.headlineNews!.totalResults!%10){
        print("==================max================");
        setState(() {
          isLoadingMore=true;
          // apiPage++;
          provider.updateCustomApiPage(3);
        });
          provider.getSportsNews();
        setState(() {
          isLoadingMore=false;
        });
      }
    }else if(provider.tpage==4){
      if(sController.position.pixels==sController.position.maxScrollExtent && provider.te_apiPage<=provider.headlineNews!.totalResults!%10){
        print("==================max================");
        setState(() {
          isLoadingMore=true;
          // apiPage++;
          provider.updateCustomApiPage(4);
        });
          provider.getTechnologyNews();

        setState(() {
          isLoadingMore=false;
        });

      }
    }

  }

  void tControl(){
    Provider.of<ProviderState>(context,listen: false).updateTpage(tabController.index);
  /*  print(tabController.index);
    print("Hello tab being changed");
    print(Provider.of<ProviderState>(context,listen: false).tpage);*/
  }

  Widget NewsContainer(NewsModel news,int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(news: news, index: index)));
      },
      child: Container(
        height: 130,width: 175,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.greenAccent,Colors.blue]),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                  padding: const EdgeInsets.only(left: 2,right: 2,top: 1,bottom: 3),
                  child: ClipRRect(
                      borderRadius:BorderRadius.circular(14),
                      child: news.articles[index].urlToImage.toString()=="null"
                      ?Image.asset("assets/noImage.png")
                      : Image.network(news.articles[index].urlToImage.toString(),
                        fit: BoxFit.cover,)
                  )
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      news.articles[index].title.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                      textAlign: TextAlign.center,
                      maxLines: 3, // Maximum number of lines
                      overflow: TextOverflow.ellipsis, // Add ellipsis at the end
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(child: Padding(padding:const EdgeInsets.symmetric(vertical: 4),child: Text(news.articles[index].publishedAt.toString()))),
                      Container(
                        height: 30,width: 80,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(10, 10))
                        ),
                        child: Center(child: Text("Read More.",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),),
                      ),

                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget HeadlineWIdget(NewsModel headlineNews){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListView.separated(
          controller: sController,
          itemCount: isLoadingMore? headlineNews.articles.length+1:headlineNews.articles.length,
          itemBuilder: (context,index){
            if(headlineNews.articles.length>index){
              return NewsContainer(headlineNews,index);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }

          }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5,) ;},
      ),
    );
  }


  Widget HealthWIdget(NewsModel healthNews){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListView.separated(
        controller: sController,
        itemCount: isLoadingMore? healthNews.articles.length+1:healthNews.articles.length,
        itemBuilder: (context,index){
          if(healthNews.articles.length>index){
            return NewsContainer(healthNews,index);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5,) ;},
      ),
    );
  }


  Widget ScienceWIdget(NewsModel scienceNews){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListView.separated(
        controller: sController,
        itemCount: isLoadingMore? scienceNews.articles.length+1:scienceNews.articles.length,
        itemBuilder: (context,index){
          if(scienceNews.articles.length>index){
            return NewsContainer(scienceNews,index);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5,) ;},
      ),
    );
  }


  Widget SportsWIdget(NewsModel sportsNews){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListView.separated(
        controller: sController,
        itemCount: isLoadingMore? sportsNews.articles.length+1:sportsNews.articles.length,
        itemBuilder: (context,index){
          if(sportsNews.articles.length>index){
            return NewsContainer(sportsNews,index);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5,) ;},
      ),
    );
  }



  Widget TechnologyWIdget(NewsModel tecnologyNews){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListView.separated(
        controller: sController,
        itemCount: isLoadingMore? tecnologyNews.articles.length+1:tecnologyNews.articles.length,
        itemBuilder: (context,index){
          if(tecnologyNews.articles.length>index){
            return NewsContainer(tecnologyNews,index);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5,) ;},
      ),
    );
  }

}

class CustomSliverAppBar extends SliverPersistentHeaderDelegate{
  final height;
  TabController tcontroller;
  NewsModel headlineNews;
  CustomSliverAppBar({required this.height,required this.tcontroller,required this.headlineNews});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Consumer<ProviderState>(
        builder: (context, provider,child) {
          int currentPage = provider.page;
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+7,),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text("Headlines",style: TextStyle(color: Colors.white70,fontSize:35))),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: BackgroundImage(shrinkOffset,context,currentPage)),
                // BuildAppBar(shrinkOffset),
              ],
            ),
          );
        }
    );
  }

  Widget BackgroundImage(shrinkOffset,context,currentPage){
    return Opacity(
      opacity: appear(shrinkOffset),
      child: Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
        child: AspectRatio(
          aspectRatio: 2.5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(height: 10,),
              PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  onPageChanged: (val){
                    Provider.of<ProviderState>(context,listen: false).updatePage(val);
                    print(val);
                  },
                  itemBuilder: (context,index){
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child:headlineNews.articles[index].urlToImage.toString()=="null"
                        ?Image.asset("assets/noImage.png")
                        :Image.network(headlineNews.articles[index].urlToImage.toString(),fit: BoxFit.cover,)
                    );
                  }
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Row(
                  children: List.generate(4, (index) => Padding(padding:const EdgeInsets.all(1),child: IndicatorDot(currentPage==index))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget IndicatorDot(bool isActive){
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isActive?Colors.black:Colors.white
      ),
    );
  }

  double disappear(double shrinkOffset){
    return shrinkOffset/height;
  }

  double appear (double shrinkOffset){
    return 1-shrinkOffset/height;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight+20;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }


}