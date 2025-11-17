import './Header.css';

function Header() {
  return (
    <header className="header">
      <div className="header-content">
        <h1 className="logo">
          <span className="logo-icon">🚚</span>
          NewarkGrub
        </h1>
        <p className="tagline">Discover the Best Food Trucks in Newark, NJ</p>
      </div>
    </header>
  );
}

export default Header;
