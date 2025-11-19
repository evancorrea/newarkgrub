import { GoogleMap, LoadScript, Marker, InfoWindow } from '@react-google-maps/api';
import { useState } from 'react';
import './Map.css';

const mapContainerStyle = {
  width: '100%',
  height: '100%'
};

// Center on Newark, NJ
const center = {
  lat: 40.735657,
  lng: -74.172367
};

const mapOptions = {
  disableDefaultUI: false,
  zoomControl: true,
  streetViewControl: false,
  mapTypeControl: false
};

function Map({ trucks, selectedTruck, onMarkerClick }) {
  const [activeMarker, setActiveMarker] = useState(null);
  const [mapError, setMapError] = useState(false);

  const handleMarkerClick = (truck) => {
    setActiveMarker(truck.id);
    onMarkerClick(truck);
  };

  // For demo purposes, show a placeholder if no API key
  if (!import.meta.env.VITE_GOOGLE_MAPS_API_KEY) {
    return (
      <div className="map-placeholder">
        <div className="map-placeholder-content">
          <h3>🗺️ Google Maps Integration</h3>
          <p>Map will display here when API key is configured.</p>
          <p className="api-key-note">
            Add your Google Maps API key to <code>.env</code> file:
            <br />
            <code>VITE_GOOGLE_MAPS_API_KEY=your_api_key</code>
          </p>
          <div className="mock-markers">
            <h4>Food Truck Locations:</h4>
            <ul>
              {trucks.map((truck) => (
                <li
                  key={truck.id}
                  className={selectedTruck?.id === truck.id ? 'selected' : ''}
                  onClick={() => onMarkerClick(truck)}
                >
                  📍 {truck.name} - {truck.location.address}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="map-container">
      <LoadScript
        googleMapsApiKey={import.meta.env.VITE_GOOGLE_MAPS_API_KEY}
        onError={() => setMapError(true)}
      >
        {mapError ? (
          <div className="map-error">
            <p>Failed to load Google Maps. Please check your API key.</p>
          </div>
        ) : (
          <GoogleMap
            mapContainerStyle={mapContainerStyle}
            center={selectedTruck ? selectedTruck.location : center}
            zoom={selectedTruck ? 15 : 13}
            options={mapOptions}
          >
            {trucks.map((truck) => (
              <Marker
                key={truck.id}
                position={{ lat: truck.location.lat, lng: truck.location.lng }}
                onClick={() => handleMarkerClick(truck)}
                icon={
                  selectedTruck?.id === truck.id
                    ? {
                        url: 'https://maps.google.com/mapfiles/ms/icons/orange-dot.png',
                        scaledSize: new window.google.maps.Size(40, 40)
                      }
                    : {
                        url: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png',
                        scaledSize: new window.google.maps.Size(40, 40)
                      }
                }
              />
            ))}

            {activeMarker && (
              <InfoWindow
                position={{
                  lat: trucks.find((t) => t.id === activeMarker)?.location.lat,
                  lng: trucks.find((t) => t.id === activeMarker)?.location.lng
                }}
                onCloseClick={() => setActiveMarker(null)}
              >
                <div className="info-window">
                  <h4>{trucks.find((t) => t.id === activeMarker)?.name}</h4>
                  <p>{trucks.find((t) => t.id === activeMarker)?.cuisine}</p>
                  <p>{trucks.find((t) => t.id === activeMarker)?.location.address}</p>
                </div>
              </InfoWindow>
            )}
          </GoogleMap>
        )}
      </LoadScript>
    </div>
  );
}

export default Map;
