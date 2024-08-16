class UnboardingContent{
  late String image;
  late String title;
  late String description;
  UnboardingContent({required this.description,required this.image, required this.title});
}
List<UnboardingContent> contents=[
  UnboardingContent(
      description: 'Pick your food from our menu\n more than 35 times',
      image: "images/screen1.png",
      title:'Select from Our\n    Best Menu'),
   UnboardingContent(
       description: 'You can pay cash on delivery and\n Card payment is available',
       image: "images/screen2.png",
       title:'Easy and Online Pay'),
   UnboardingContent(
       description: 'Deliver your food at your\n Doorstep',
       image:"images/screen3.png",
       title:'Quick Delivery at your Doorstep' )
];