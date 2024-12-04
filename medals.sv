  `define  COUNTRIES 10
  `define  EVENTS 50
  `define   SIZE 6 
 typedef  struct {
	string name;
	bit[`SIZE-1:0] gold;
	bit[`SIZE-1:0] silver;
	bit[`SIZE-1:0] bronze;
 } medal_t;

	class sample ;
		 rand  bit[`SIZE-1:0] goldA  [`COUNTRIES-1:0];
		 rand  bit[`SIZE-1:0] silverA[`COUNTRIES-1:0];
		 rand  bit[`SIZE-1:0] bronzeA[`COUNTRIES-1:0];
	 constraint  medals_c{
		
	 		 goldA.sum()== `EVENTS;//50
	 		 silverA.sum()==`EVENTS;
	 		 bronzeA.sum()==`EVENTS;
	 			
			 foreach(goldA[i]){
			   	goldA[i] inside {[0:`EVENTS]};
			   	silverA[i] inside {[0:`EVENTS]};
			   	bronzeA[i] inside {[0:`EVENTS]};
	 		 }
	 }
	endclass
 module top;
	 medal_t  country[$:`COUNTRIES-1];
	 sample s;

	 initial begin
	 		s=new();
			assert(s.randomize());

				$display("sum of  bronzeA =%0d ,  bronzeA=%p",s.bronzeA.sum(),s.bronzeA);
				$display("sum of  silverA =%0d ,silverA=%p",s.silverA.sum(),s.silverA);
				$display("sum of  goldA =%0d ,  goldA=%p",s.goldA.sum(),s.goldA);
			for(int i=0;i<`COUNTRIES;i++)begin
					country[i].name  =$sformatf("country_%0d",i);
					country[i].gold  =s.goldA[i];
					country[i].silver=s.silverA[i];
					country[i].bronze=s.bronzeA[i];
			end
	 $display(" tokiyo :  country=%p",country);

// ranking based on  no of gold medals
		country.rsort  with (item.gold);
	 $display(" \n ################  country ranking based on  gold  #################### \n\ttokiyo :  country=%p",country);
		country.rsort  with (item.bronze);
	 $display(" \n ################  country ranking based on  bronze #################### \n\ttokiyo :  country=%p",country);
		country.rsort  with (item.silver);
	 $display(" \n ################  country ranking based on  silver #################### \n\ttokiyo :  country=%p",country);
		country.rsort  with (item.gold+ item.silver + item.bronze);
	 $display(" \n ################  country ranking based on   all medals  #################### \n\ttokiyo :  country=%p",country);
		country.rsort  with ({item.gold, item.silver , item.bronze});
	 $display(" \n ################  country ranking based on   all medals  with  high priority  #################### \n\ttokiyo :  country=%p",country);
	 end
 endmodule


