# Podsumowanie katalogu `packages/`

## Przegląd katalogu `packages/`

### 1. `l1_simple_bloc`
- **Cel:** Najprostszy przykład użycia BLoC w Flutterze.
- **Opis:** Zawiera klasyczny licznik (counter) zrealizowany przy pomocy BLoC. Uczy podstawowego przepływu: event → bloc → state → UI.
- **Kod:** Minimalny, idealny na start nauki BLoC.

---

### 2. `l2_simple_bloc`
- **Nowe widgety:**  
  - Nadal `BlocProvider` i `BlocBuilder`.
- **Techniki:**  
  - Więcej eventów i stanów, pokazuje jak rozbudowywać logikę bloc-a i reagować na różne akcje użytkownika.
  - **Obsługa loadingu:** wprowadzenie stanu ładowania (np. wyświetlanie spinnera podczas przetwarzania eventu), co pozwala lepiej zarządzać asynchronicznymi operacjami i informować użytkownika o trwającym procesie.

---

### 3. `l3_simple_bloc`
- **Cel:** Kolejny krok w rozwoju aplikacji z BLoC.
- **Opis:** W tym przykładzie pojawia się także **BlocListener** do reagowania na zmiany stanu bez przebudowy UI.

---

### 4. `l4_data_bloc`
- **Cel:** Praca z danymi i BLoC.
- **Opis:** Przykład ładowania danych (np. lista produktów) przez BLoC. Pokazuje, jak obsługiwać asynchroniczne źródła danych i stany ładowania/sukcesu/błędu.
- **Kod:** BLoC do pobierania i prezentacji listy danych.

---

### 5. `l5_data_bloc_create_value`
- **Cel:** Tworzenie nowych wartości przez BLoC.
- **Opis:** W tym przykładzie pokazana jest **różnica podejścia do BlocProvider**:
  - `BlocProvider(create: ...)` – tworzy nową instancję bloc-a przy budowie widgetu.
  - `BlocProvider.value(value: ...)` – przekazuje już istniejącą instancję bloc-a (np. gdy chcemy przekazać bloc do pod-widoku, nie tworząc nowego).
- **Kod:** BLoC do obsługi tworzenia i walidacji nowych danych, z przykładami obu podejść do BlocProvider.

---

### 6. `l6_bloc_above_main`
- **Cel:** Przykład z globalnym BLoC nad MaterialApp.
- **Opis:** Pokazuje, jak udostępnić BLoC (np. koszyk) globalnie w aplikacji, by był dostępny na wszystkich podstronach. Zawiera też zaawansowane przykłady pracy z wieloma blocami (np. produkty, koszyk, szczegóły produktu).
- **Kod:** 
  - `cart_bloc` – globalny BLoC koszyka.
  - `data_bloc` – BLoC do ładowania listy produktów.
  - `detail_bloc` – BLoC do szczegółów produktu.
  - Przykłady przekazywania i używania bloców w różnych widokach.

---

### 7. `l7_event_tranformation`
- **Cel:** Pokazanie różnicy między podejściem concurrent i sequence w obsłudze eventów w BLoC.
- **Opis:** Przykłady ilustrują, jak różne strategie obsługi eventów (przetwarzanie równoległe vs sekwencyjne) wpływają na zachowanie aplikacji. Uczy, jak świadomie wybrać odpowiednią strategię w zależności od potrzeb biznesowych i UX.
- **Kod:** BLoC z przykładami obsługi eventów w trybie concurrent (równoległym) i sequence (sekwencyjnym), np. dla wyszukiwania lub pobierania danych.

---

### 8. `l8_data_bloc_with_search`
- **Cel:** Pokazanie technik transformowania eventów w BLoC.
- **Opis:** Przykład, gdzie kluczowe jest przetwarzanie i transformowanie eventów użytkownika (np. wpisywanie tekstu do wyszukiwarki) za pomocą operatorów takich jak debounce, throttle czy switchMap. Pozwala to na optymalizację wydajności i lepszą obsługę interakcji użytkownika.
- **Kod:** BLoC z dynamicznym wyszukiwaniem, gdzie eventy są transformowane przed przetworzeniem (np. debounce przy wyszukiwaniu, throttle przy szybkim klikaniu).

---

### 9. `data_service`
- **Cel:** Warstwa serwisowa z danymi i logiką biznesową.
- **Opis:** Zawiera implementacje serwisów (np. ProductService, CartService) oraz modele domenowe (np. Product, Cart). Używane przez pozostałe paczki do symulacji backendu lub jako źródło danych.
- **Kod:** Klasy serwisowe, modele, mockowane dane.

---

## Widgety i techniki BLoC w poszczególnych katalogach

### 1. `l1_simple_bloc`
- **Nowe widgety:**  
  - `BlocProvider` – podstawowy widget do udostępniania bloc-a w drzewie widgetów.
  - `BlocBuilder` – buduje UI na podstawie zmian stanu bloc-a.
- **Techniki:**  
  - Najprostszy przepływ event → bloc → state → UI.

---

### 2. `l2_simple_bloc`
- **Nowe widgety:**  
  - Nadal `BlocProvider` i `BlocBuilder`.
- **Techniki:**  
  - Więcej eventów i stanów, pokazuje jak rozbudowywać logikę bloc-a i reagować na różne akcje użytkownika.
  - **Obsługa loadingu:** wprowadzenie stanu ładowania (np. wyświetlanie spinnera podczas przetwarzania eventu), co pozwala lepiej zarządzać asynchronicznymi operacjami i informować użytkownika o trwającym procesie.

---

### 3. `l3_simple_bloc`
- **Nowe widgety:**  
  - Możliwe użycie kilku `BlocProvider` lub zagnieżdżonych bloców.
  - **BlocListener** – pozwala reagować na zmiany stanu bloc-a bez przebudowy UI (np. wyświetlanie snackbarów, dialogów).
- **Techniki:**  
  - Praca z wieloma blocami, przekazywanie bloców do pod-widoków.
  - Reagowanie na zmiany stanu bloc-a za pomocą BlocListener.

--- 