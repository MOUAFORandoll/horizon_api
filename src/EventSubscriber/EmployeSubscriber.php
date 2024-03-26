<?php

namespace App\EventSubscriber;

use ApiPlatform\Core\EventListener\EventPriorities;

use App\Entity\Employe;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Event\ViewEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use App\FunctionU\MyFunction;

final class EmployeSubscriber extends AbstractController implements EventSubscriberInterface
{

    private $em;

    public function __construct(
        EntityManagerInterface $em,

    ) {
        $this->em = $em;
    }

    public static function getSubscribedEvents()
    {
        return [
            KernelEvents::VIEW => ['operationAfterCreateAMember', EventPriorities::POST_WRITE]
        ];
    }
    public function operationAfterCreateAMember(ViewEvent $event): void
    {
        $employe = $event->getControllerResult();
        $method = $event->getRequest()->getMethod();
        if ($employe instanceof Employe && Request::METHOD_POST === $method) {

            $matricule
                =   $this->generateMatricule();
            $employe->setMatricule($matricule);
            $this->em->persist($employe);
            $this->em->flush();
        }
    }
    public function generateMatricule()
    {

        $randomNumber = random_int(1000, 9999);

        $matricule = "HS_LT_" . date("Y") . "_" . $randomNumber;

        $existingEmploye = $this->em->getRepository(Employe::class)->findOneBy(['matricule' => $matricule]);


        if ($existingEmploye) {
            $this->generateMatricule();
        }
        return   $matricule;
    }
}
