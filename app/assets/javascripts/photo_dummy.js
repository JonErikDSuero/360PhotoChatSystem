var div = document.getElementById('container');
var PSV = new PhotoSphereViewer({
  panorama: '/assets/sun.jpg',
  container: div,
  time_anim: 3000,
  navbar: true,
  navbar_style: {
    backgroundColor: 'rgba(58, 67, 77, 0.7)'
  }
});

