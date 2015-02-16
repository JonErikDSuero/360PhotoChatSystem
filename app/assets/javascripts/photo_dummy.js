var div = document.getElementById('container');
var PSV = new PhotoSphereViewer({
  panorama: window.location.origin+$("#container").data("imageUrl"),
  container: div,
  time_anim: 10,
  navbar: false,
  navbar_style: {
    backgroundColor: 'rgba(58, 67, 77, 0.7)'
  }
});

$('body').on('click', '#take-a-pic', function(){
  this.href = PSV.getPictureUrl("image/png");
  this.download = "bubl Picture.png"
});

