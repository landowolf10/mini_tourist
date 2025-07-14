import 'package:flutter/material.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniTourist'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'EMPRESA LÍDER EN PROMOCIÓN DE NEGOCIOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '¡SIEMPRE AL PASO DE TUS CLIENTES!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '¿Qué hacemos y quiénes somos?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'MiniTourist Cards es una empresa constituida conforme a la legislación mexicana, donde se busca, a través de un sistema de publicitación relativamente nuevo y aún no muy explotado en nuestro país, consolidarnos en el gusto de consumidores, empresarios y prestadores de servicios públicos como una herramienta que, en el consumidor final, influya de manera útil al momento de decidirse a comprar algún bien, visitar algún sitio o contratar algún servicio. Y en el anunciante, sirva como una herramienta eficaz para la promoción y venta de sus servicios y productos.\n\n'
              'Por el momento, la base y el asiento principal de nuestras operaciones se encuentra en Ixtapa-Zihuatanejo, estado de Guerrero México, mismo que nos servirá de plataforma de impulso para expandirnos hacia otros lugares que, por su ubicación estratégica y sinergia comercial, representarían plazas naturales de crecimiento para nuestro concepto publicitario y nuestros servicios.\n\n'
              'MiniTourist Cards está conformada por gente joven y entusiasta, que ha creído en este proyecto y lo ha hecho suyo, siendo todos ellos parte de las diferentes áreas que le dan cuerpo, forma y funcionalidad a esta empresa visionaria.\n\n'
              'Actualmente, MiniTourist Cards cuenta con una Dirección General y Relaciones Públicas, un área de Ventas, una área de Diseño, Programación y Sistemas Digitales, un área de Control y Estadística, un área Contable, así como con un área de Crédito y Cobranza.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            const Divider(thickness: 2),
            const SizedBox(height: 16),

            // MISIÓN
            _buildSectionWithIcon(
              svgPath: 'lib/assets/images/mision.png',
              title: 'Misión',
              text: 'MiniTourist Cards busca ofrecer a los comerciantes y prestadores de servicios, un nuevo esquema para publicitar sus productos y/o servicios, en un formato moderno de diseño útil, atractivo y novedoso mediante tarjetas digitales, disponibles en plataformas electrónicas de fácil acceso, tales como páginas web y Apps cuya disposición es muy accesible y al alcance de los turistas y potenciales consumidores.\n\n'
              'Para el turista y potencial consumidor, MiniTourist Cards busca ser una herramienta útil,práctica y de muy fácil manejo y descarga a través de computadoras y dispositivoselectrónicos tales como teléfonos celulares y tablets,, donde éstos encuentren toda lainformación básica sobre sitios, productos y servicios, tales como sitios de interés,atracciones, eventos, restaurantes, tiendas, playas y cualquier otro tipo de locación, que les sirva para tomar decisiones sobre que hacer, donde comprar y a donde ir.',
            ),

            const SizedBox(height: 24),

            // VISIÓN
            _buildSectionWithIcon(
              svgPath: 'lib/assets/images/vision.png',
              title: 'Visión',
              text:'En MiniTourist Cards buscamos consolidarnos como empresa líder en publicidad local y focalizada, dirigida al mercado turístico y a cualquier potencial consumidor que requieraalgún producto o servicio en las diferentes plazas en las que tenemos presencia, al tenercubiertos con nuestras tarjetas digitales e información, los diferentes rubros de productos,lugares y servicios que se ofrecen y se demandan, accesibles a través de nuestras plataformas web y móvil y, siendo para esto, un objetivo primordial tener presencia y anuncios sobre MiniTourist Cards y sus servicios, en los lugares de paso, acceso, arribo osalida de turistas y consumidores potenciales de la población general.\n\n'
              'Y como consecuencia de lo anterior, convertirnos en una empresa que, por los resultadospositivos que ofrezca a sus anunciantes y por el servicio que brinde a potencialesconsumidores que decidan descargar las MiniTourist Cards, seamos la opción de guíacomercial y turística más buscada y requerida en los lugares donde tengamos presencia.\n\n'
              'MiniTourist Cards, conforme al éxito y consolidación que se tenga en Ixtapa-Zihuatanejocomo plaza Mater de nuestro negocio y operaciones, buscará abrir otras plazas de negocio yoperación utilizando siempre la marca, las políticas y los conceptos que le dan su valor y prestigio.',
            ),

            const SizedBox(height: 24),

            // VALORES
            _buildSectionWithIcon(
              svgPath: 'lib/assets/images/valores.png',
              title: 'Valores',
              text:'En MiniTourist Cards consideramos fundamental la práctica constante y sistemática devalores que, traducidos en acciones, nos permitan crecer y que se nos visualice como unaempresa responsable con calidad humana, social y ecológica, comprometidos positivamentecon nuestro entorno, basados enunciativa y no limitativamente, en los siguientes principios: Actitud, honestidad, responsabilidad, lealtad, calidad en el servicio, colaboración y trabajo en equipo, participación activa y propositiva',
            ),
          ],
        ),
      ),
      drawer: const AppDrawer()
    );
  }

  Widget _buildSectionWithIcon({
    required String svgPath,
    required String title,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          svgPath,
          width: 48,
          height: 48
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}